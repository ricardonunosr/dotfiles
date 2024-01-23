#zmodload zsh/zprof

export PROMPT='%F{white}%m:%F{2}%~ %F{white}$%f '

source ~/.aliases
source ~/.workzshrc

# Environment
export PATH="${HOME}/.local/bin:${PATH}"
export EDITOR='vim'
export LANG=en_US.UTF-8
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
bindkey -s ^f "tmux-sessionizer\n"
source /opt/ros/noetic/setup.zsh

#zprof
