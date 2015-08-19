ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

source ~/.aliases

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
  brew
  git
  history-substring-search
  jira
  tmux
  tmuxinator
  vagrant
)

source $ZSH/oh-my-zsh.sh

export PATH="/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin"
export EDITOR='vim'
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'
export TERM=xterm-256color

source ~/.zsh_colorscheme
source ~/.zsh_autosuggestions
