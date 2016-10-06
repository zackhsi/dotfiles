# Common zsh/bash configuration

# Code
export SRC=$HOME/src

# Devbox
alias c=control
export DOCKER_HOST="tcp://127.0.0.1:2375"

# Directories
alias dev="cd $SRC/devbox"
alias dot="cd ~/homespace/dotfiles"
alias h="cd ~/homespace"
alias o="cd $SRC/ops"
alias s="cd $SRC"

# ls
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"

# Editor
export EDITOR='nvim'

# FZF
export FZF_DEFAULT_COMMAND='ag -l -U -g ""'

# Git
alias g='git'
alias gbc="git branch | grep -v master | xargs git branch -d"
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gl='git pull'
alias gl='git pull'
alias glg='git log --stat'
alias glg='git log --stat'
alias gp='git push'
alias grev='git rev-parse HEAD'
alias gst='git status'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip--"'
# Git(hub)
alias pr="hub pull-request"

# Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# GNU Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Neovim
alias v=nvim
alias vi=nvim
alias vim=nvim

# OSX
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Pager
export PAGER="less -IM"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Search
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'

# Shellcheck
export SHELLCHECK_OPTS="-e SC1091"

# ssh
if ! ssh-add -l > /dev/null; then
  ssh-add 2>/dev/null
fi

# TERM
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi

# thefuck
alias fk=fuck

# Tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
