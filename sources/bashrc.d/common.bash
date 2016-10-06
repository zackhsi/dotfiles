# Common zsh/bash configuration

export COLORSCHEME=onedark
export EDITOR='nvim'
export PAGER="less -IM"

# Code
export SRC=$HOME/src

# Search
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'

# FZF
export FZF_DEFAULT_COMMAND='ag -l -U -g ""'

# Git aliases
alias g='git'
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcan!='git commit -v -a --no-edit --amend'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gl='git pull'
alias glg='git log --stat'
alias gl='git pull'
alias glg='git log --stat'
alias gp='git push'
alias gst='git status'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip--"'

# Tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# GNU Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Python
export PYTHONDONTWRITEBYTECODE=1

# Neovim
alias v=nvim
alias vi=nvim
alias vim=nvim

# thefuck
alias fk=fuck

# shellcheck
export SHELLCHECK_OPTS="-e SC1091"

# ssh
if ! ssh-add -l > /dev/null; then
  ssh-add 2>/dev/null
fi

