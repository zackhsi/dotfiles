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

# JIRA
JIRA_URL=https://lyftme.atlassian.net
JIRA_DASHBOARD="true"

# Base16 Shell
if [ ! -d ~/.config/base16-shell ]; then
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Android
export ANDROID_HOME='/Applications/Android Studio.app/sdk'
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

### Heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# zsh-autosuggestions
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone git://github.com/tarruda/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone git://github.com/jimmijj/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
fi

# Load zsh-syntax-highlighting.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

zmodload zsh/terminfo # zsh substring history with up/down/p/n
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
