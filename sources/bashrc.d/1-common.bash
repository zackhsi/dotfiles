# Common zsh/bash configuration

# Code
export SRC=$HOME/go/src/github.com/lyft

# Devbox
alias c=control
export DOCKER_HOST="tcp://127.0.0.1:2375"

# Directories
alias cont="cd $SRC/containers"
alias d="cd ~/Desktop"
alias dev="cd $SRC/devbox"
alias dot="cd ~/homespace/dotfiles"
alias h="cd ~/homespace"
alias o="cd $SRC/ops"
alias oss="cd ~/oss"
alias r="cd $HOME/repos/lyft"
alias s="cd $SRC"
alias sim="cd $SRC/simulatedrides"
alias user="cd $SRC/python-lyft-userclient"

# dotfiles bin
export PATH=~/homespace/dotfiles/bin:$PATH

# ls
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"

# Editor
export EDITOR='nvim'

# FZF
export FZF_DEFAULT_COMMAND='ag -l -U -g ""'
export FZF_DEFAULT_OPTS='--color 16,bg+:-1'
export FZF_CTRL_R_OPTS='--sort'

# Golang
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

# GNU Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Homebrew
PATH="/usr/local/sbin:$PATH"

# Hub
alias pr="hub pull-request"

# Neovim
alias v=nvim
alias vi=nvim
alias vim=nvim

# Node
export PATH=~/homespace/dotfiles/node_modules/.bin:$PATH

# OSX
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Pager
export PAGER="less -IM"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Rust
export PATH=$PATH:~/.cargo/bin

# Search
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'

# Shellcheck
export SHELLCHECK_OPTS="-e SC1091"

# TERM
export TERM=xterm-color

# thefuck
alias fk=fuck

# Tmux
alias tmux='tmux -u'
alias ta='tmux -u attach -t'
alias tad='tmux -u attach -d -t'
alias ts='tmux -u new-session -s'
alias tl='tmux -u list-sessions'
alias tksv='tmux -u kill-server'
alias tkss='tmux -u kill-session -t'
