export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="zshfish"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

plugins=(
	fzf
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source ~/aliases
. /usr/share/autojump/autojump.sh

# Input Highlighting like fisk. Thanks @strager.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
typeset -A ZSH_HIGHLIGHT_STYLES
_command_style='fg=26'
_argument_style='fg=39'
_error_style='fg=red'
ZSH_HIGHLIGHT_STYLES[alias]="${_command_style}"
ZSH_HIGHLIGHT_STYLES[arg0]="${_command_style}"
ZSH_HIGHLIGHT_STYLES[builtin]="${_command_style}"
ZSH_HIGHLIGHT_STYLES[command]="${_command_style},underline"
ZSH_HIGHLIGHT_STYLES[comment]='fg=10'
ZSH_HIGHLIGHT_STYLES[default]="${_argument_style}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="${_error_style}"
ZSH_HIGHLIGHT_STYLES[double-hypen-option]="${_argument_style}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="${_error_style}"
ZSH_HIGHLIGHT_STYLES[function]="${_command_style}"
ZSH_HIGHLIGHT_STYLES[hashed-command]="${_command_style},underline"
ZSH_HIGHLIGHT_STYLES[path]="${_argument_style},underline"
ZSH_HIGHLIGHT_STYLES[precommand]="${_command_style}"
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=093'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="${_argument_style}"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="${_error_style}"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

