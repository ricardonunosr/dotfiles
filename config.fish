if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x EDITOR vim
set -x FZF_DEFAULT_OPTS --exact

# git
function ga
  git add $argv
end

function gc
  git commit $argv
end

function gco
  git checkout $argv
end

function gcp
  git cherry-pick $argv
end

function gd
  git diff $argv
end

function gl
  git log $argv
end

function gp
  git push $argv
end

function gs
  git status
end

function gf
  git fetch --all --prune --tags
end

function gca
  git add -A; and git commit $argv
end

# utils
function ll
  ls -lah $argv
end

function mkpass
  head -c 12 /dev/urandom | base64
end

function fish_user_key_bindings
  fzf_key_bindings
end

function clbin
  curl -F 'clbin=<-' https://clbin.com
end

