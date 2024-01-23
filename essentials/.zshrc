# zmodload zsh/zprof

export PROMPT='%F{green}%m:%F{blue}%~ %F{white}$%f '

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

source ~/.aliases
[ -f ~/.workzshrc ] && source ~/.workzshrc

# Environment
export PATH="${HOME}/.local/bin:${PATH}"
export EDITOR='vim'
export LANG=en_US.UTF-8

# fzf
if [[ $(uname) == "Darwin" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else # Linux
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

bindkey -s ^f "tmux-sessionizer\n"

# zprof
