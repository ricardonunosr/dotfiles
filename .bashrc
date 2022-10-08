export EDITOR='vim'
export PS1='\u@\h:\[\e[01;32m\]\w\[\e[0m\]\$ '


alias ls='ls --color'
alias ll="ls -lah"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gdiff="git diff"
alias gl="git prettylog"
alias gp="git push"
alias gs="git status"
alias gt="git tag"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$OSTYPE" == "darwin"* ]]; then
	source ~/.fzf.bash
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
	source /usr/share/doc/fzf/examples/completion.bash
fi