export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="zshfish"
HYPHEN_INSENSITIVE="true"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source ~/aliases
