# Common zsh/bash configuration

# Code
export SRC=$HOME/src

# Devbox
alias c=control
export DOCKER_HOST="tcp://127.0.0.1:2375"

# Directories
alias cont="cd $SRC/containers"
alias dev="cd $SRC/devbox"
alias dot="cd ~/homespace/dotfiles"
alias h="cd ~/homespace"
alias o="cd $SRC/ops"
alias oss="cd ~/oss"
alias s="cd $SRC"

# ls
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"

# Editor
export EDITOR='nvim'

# FZF
export FZF_DEFAULT_COMMAND='ag -l -U -g ""'
export FZF_DEFAULT_OPTS='--color 16'
export FZF_CTRL_R_OPTS='--sort'

# Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

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
export TERM=xterm-16color

# thefuck
alias fk=fuck

# Tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
