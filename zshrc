###############################################################################
# ZSH
###############################################################################
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="robbyrussell"
export HIST_STAMPS="mm/dd/yyyy"
plugins=(
  brew
  docker
  git
  hub
  jira
  pip
  thefuck
  tmux
  vagrant
)

###############################################################################
# Pretty colors
###############################################################################
export BACKGROUND=dark
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi
if [ ! -d ~/.config/base16-shell ]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.$BACKGROUND.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

###############################################################################
# Exports
###############################################################################

export EDITOR='vim'
export PAGER="less -IM"

# Search
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'

# Code
export SRC=$HOME/src

# Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


###############################################################################
# Aliases/functions
###############################################################################

source ~/.zsh_aliases

###############################################################################
# Misc
###############################################################################

# JIRA
JIRA_URL=https://lyftme.atlassian.net
JIRA_DEFAULT_ACTION="dashboard"

# GNU Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Homebrew
PATH=/usr/local/sbin:$PATH

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -l -U -g ""'

# Tmux Plugin Manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
fi

# Devbox
PROJECT_DIR=$(awk -F "=" '/project_dir/ {print $2}' ~/.devbox | tr -d " ")
export PATH=$PROJECT_DIR/.bin:$PATH
export DOCKER_HOST="tcp://$(awk -F "=" '/ip_address/ {print $2}' ~/.devbox | tr -d " "):2375"

# Finally, source it
source $ZSH/oh-my-zsh.sh
