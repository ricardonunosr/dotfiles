---
name: mcap-analysis
description: "Use when inspecting or analysing .mcap recordings (ROS 2 / protobuf / JSON logs) — listing topics, decoding messages, extracting signals or timestamps, or writing Python scripts that read MCAP files."
---

# MCAP Analysis

## Rules

- Do NOT create virtualenvs or `pip install` anything. Use `uv` (it caches
  dependencies, so runs start in well under a second).
- Start with the `mcap` CLI. Only write Python when the CLI cannot answer
  the question.
- Put throwaway scripts and outputs in `/tmp/opencode`, never in the repo.
- Recordings are often several GB. Always restrict reads by topic and, when
  possible, by time window. Never dump a whole file to stdout.

## 1. Quick inspection with the CLI

```bash
mcap info <file>                    # duration, start/end time, channels, message counts
mcap list channels <file>           # topic, schema, encoding per channel
mcap list schemas <file>
mcap cat <file> --topics /a,/b --json | head -n 20
mcap cat <file> --topics /a --json --start-secs <t0> --end-secs <t1>
mcap filter <file> -o /tmp/opencode/slice.mcap -y '^/a$' -S <t0_ns> -E <t1_ns>   # cut a smaller file
```

All times are absolute log times (see "start" in `mcap info`), not offsets
from the beginning of the recording. `cat` takes `--start-secs`/`--end-secs`
(or `--start-nsecs`/`--end-nsecs`). `filter -S/-E` takes integer nanoseconds or
RFC3339, and `-y` is a topic regex.

`mcap cat --json` pipes well into `jq`, for example:

```bash
mcap cat <file> --topics /a --json | jq -c '{t: .log_time, v: .message.some.field}'
```

## 2. Python scripts with uv

Write scripts with an inline dependency header (PEP 723) and run them with
`uv run`:

```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = ["mcap", "mcap-protobuf-support", "protobuf"]
# ///
import sys

from mcap.reader import make_reader
from mcap_protobuf.decoder import DecoderFactory

path, topic = sys.argv[1], sys.argv[2]
with open(path, "rb") as f:
    reader = make_reader(f, decoder_factories=[DecoderFactory()])
    for schema, channel, message, proto in reader.iter_decoded_messages(topics=[topic]):
        print(message.log_time, proto)
```

```bash
uv run /tmp/opencode/analyse.py <file> /some/topic
```

For one-offs without a file:

```bash
uv run --no-project --with mcap --with mcap-protobuf-support --with protobuf python -c '...'
```

Decoder packages by message encoding (check with `mcap list channels`):

| Encoding   | Package                 | Decoder                                    |
|------------|-------------------------|--------------------------------------------|
| protobuf   | `mcap-protobuf-support` | `mcap_protobuf.decoder.DecoderFactory`     |
| ros2 / cdr | `mcap-ros2-support`     | `mcap_ros2.decoder.DecoderFactory`         |
| ros1       | `mcap-ros1-support`     | `mcap_ros1.decoder.DecoderFactory`         |
| json       | none                    | `json.loads(message.data)`                 |

Add `pandas`, `numpy` or `matplotlib` to `dependencies` only when needed. Save
plots to `/tmp/opencode/*.png` instead of calling `plt.show()`.

## 3. Reader API reference

- `reader.get_summary()`: `.statistics` (message counts, start/end time),
  `.channels`, `.schemas`, without reading any messages.
- `reader.iter_decoded_messages(topics=[...], start_time=ns, end_time=ns, log_time_order=True)`
  yields `(schema, channel, message, decoded)`.
- `reader.iter_messages(...)` does the same without decoding (raw `message.data`),
  which is much faster when only timestamps or counts are needed.
- `message.log_time` and `message.publish_time` are integer nanoseconds.
- Protobuf to dict: `google.protobuf.json_format.MessageToDict(decoded)`.

## Setup on a new machine

If `uv` or `mcap` is missing:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
# mcap CLI: download "mcap-linux-amd64" from https://github.com/foxglove/mcap/releases
# into ~/.local/bin/mcap and chmod +x it
```
