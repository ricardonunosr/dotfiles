#!/bin/bash

set -euo pipefail

INTERNAL_OUTPUT="eDP-1"
SCRIPT_PATH="${HOME}/.config/i3/scripts/display-layout.sh"
LAPTOP_PROFILE="${LAPTOP_PROFILE:-default}"
EXTERNAL_PROFILE="${EXTERNAL_PROFILE:-external}"
CLONE_PROFILE="${CLONE_PROFILE:-clone}"
EXTEND_PROFILE="${EXTEND_PROFILE:-extend}"

refresh_external_outputs() {
    mapfile -t EXTERNAL_OUTPUTS < <(xrandr --query | awk '/ connected/ {print $1}' | grep -v "^${INTERNAL_OUTPUT}$" || true)
}

profile_exists() {
    local profile_name="$1"

    autorandr --list 2>/dev/null | grep -qx "$profile_name"
}

load_profile() {
    local profile_name="$1"

    if ! command -v autorandr >/dev/null 2>&1; then
        i3-nagbar -t error -m "autorandr is not installed"
        exit 1
    fi

    if ! profile_exists "$profile_name"; then
        i3-nagbar -t error -m "autorandr profile '${profile_name}' not found"
        exit 1
    fi

    autorandr --load "$profile_name"
    refresh_external_outputs
}

refresh_external_outputs

move_all_to_output() {
    local output="$1"

    i3-msg "workspace 1; move workspace to output ${output}; workspace 2; move workspace to output ${output}; workspace 3; move workspace to output ${output}; workspace 4; move workspace to output ${output}; workspace 5; move workspace to output ${output}; workspace 6; move workspace to output ${output}; workspace 7; move workspace to output ${output}; workspace 8; move workspace to output ${output}; workspace 9; move workspace to output ${output}" >/dev/null
}

move_split_layout() {
    local external_output="$1"

    i3-msg "workspace 1; move workspace to output ${external_output}; workspace 2; move workspace to output ${external_output}; workspace 3; move workspace to output ${external_output}; workspace 4; move workspace to output ${external_output}; workspace 5; move workspace to output ${external_output}; workspace 6; move workspace to output ${external_output}; workspace 7; move workspace to output ${external_output}; workspace 8; move workspace to output ${external_output}; workspace 9; move workspace to output ${INTERNAL_OUTPUT}" >/dev/null
}

build_external_command() {
    local command=(xrandr --output "$INTERNAL_OUTPUT" --off)
    local previous_output=""

    for output in "${EXTERNAL_OUTPUTS[@]}"; do
        command+=(--output "$output" --auto)

        if [[ -z "$previous_output" ]]; then
            command+=(--primary)
        else
            command+=(--right-of "$previous_output")
        fi

        previous_output="$output"
    done

    printf '%q ' "${command[@]}"
}

build_clone_command() {
    local command=(xrandr --output "$INTERNAL_OUTPUT" --auto --primary)

    for output in "${EXTERNAL_OUTPUTS[@]}"; do
        command+=(--output "$output" --auto --same-as "$INTERNAL_OUTPUT")
    done

    printf '%q ' "${command[@]}"
}

build_extend_command() {
    local command=(xrandr --output "$INTERNAL_OUTPUT" --auto)
    local previous_output="$INTERNAL_OUTPUT"
    local first_external=1

    for output in "${EXTERNAL_OUTPUTS[@]}"; do
        command+=(--output "$output" --auto --right-of "$previous_output")

        if [[ "$first_external" -eq 1 ]]; then
            command+=(--primary)
            first_external=0
        fi

        previous_output="$output"
    done

    printf '%q ' "${command[@]}"
}

show_menu() {
    if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
        i3-nagbar -t error -m "No external display detected"
        exit 1
    fi

    i3-nagbar -t warning -m "Select display mode:" \
        -b "Laptop" "${SCRIPT_PATH} laptop" \
        -b "External" "${SCRIPT_PATH} external" \
        -b "Clone" "${SCRIPT_PATH} clone" \
        -b "Extend" "${SCRIPT_PATH} extend"
}

apply_laptop() {
    load_profile "$LAPTOP_PROFILE"
    move_all_to_output "$INTERNAL_OUTPUT"
}

apply_external() {
    load_profile "$EXTERNAL_PROFILE"

    if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
        i3-nagbar -t error -m "No external display detected after loading ${EXTERNAL_PROFILE}"
        exit 1
    fi

    local primary_external="${EXTERNAL_OUTPUTS[0]}"
    move_all_to_output "$primary_external"
}

apply_clone() {
    load_profile "$CLONE_PROFILE"
    move_all_to_output "$INTERNAL_OUTPUT"
}

apply_extend() {
    load_profile "$EXTEND_PROFILE"

    if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
        i3-nagbar -t error -m "No external display detected after loading ${EXTEND_PROFILE}"
        exit 1
    fi

    local primary_external="${EXTERNAL_OUTPUTS[0]}"
    move_split_layout "$primary_external"
}

case "${1:-menu}" in
    laptop)
        apply_laptop
        ;;
    external)
        if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
            i3-nagbar -t error -m "No external display detected"
            exit 1
        fi
        apply_external
        ;;
    clone)
        if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
            i3-nagbar -t error -m "No external display detected"
            exit 1
        fi
        apply_clone
        ;;
    extend)
        if [[ ${#EXTERNAL_OUTPUTS[@]} -eq 0 ]]; then
            i3-nagbar -t error -m "No external display detected"
            exit 1
        fi
        apply_extend
        ;;
    menu)
        show_menu
        ;;
    *)
        i3-nagbar -t error -m "Unknown display mode: ${1}"
        exit 1
        ;;
esac