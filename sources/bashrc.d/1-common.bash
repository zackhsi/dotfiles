# Common zsh/bash configuration

# Devbox
alias c=control

# Directories
alias d="cd ~/Desktop"
alias desk="cd ~/Desktop"
alias dot="cd ~/dotfiles"
alias oss="cd ~/oss"
alias s="cd ~/stripe"

# dotfiles bin
export PATH=~/dotfiles/bin:$PATH

# ls
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"

# Editor
export EDITOR='nvim'

# FZF
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*" --glob "!bazel-bin/*" --glob "!.ijwb/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
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
alias view='nvim -R'

# Node
export PATH=~/dotfiles/node_modules/.bin:$PATH

# OSX
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Pager
export PAGER="less -IM"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Scala
export PATH="/usr/local/opt/scala@2.11/bin:$PATH"

# Search
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --color=auto'

# Shellcheck
export SHELLCHECK_OPTS="-e SC1091"

# TERM
export TERM=xterm-256color-italic

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
