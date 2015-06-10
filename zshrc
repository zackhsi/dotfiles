ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Aliases
alias gbc="git branch | grep -v -e 'master' -e 'release' | xargs git branch -d"
alias mux=tmuxinator

alias dev="~/workspace/devbox"
alias ats="~/workspace/ats"
alias api="~/workspace/instant-server"
alias ios="~/workspace/instant-ios"
alias green="~/workspace/green"
alias www2="~/workspace/lyft.com"
alias mock="~/workspace/mock-lyft-api"
alias mocks="~/workspace/mocks"
alias dot="~/homespace/dotfiles"
alias readonlymongo="~/workspace/readonlymongo"
alias venmo="~/homespace/venmo"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git vagrant brew jsontools mongodb history-substring-search tmux tmuxinator hub)

source $ZSH/oh-my-zsh.sh

export PATH="/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin"
export EDITOR='vim'
export ACK_OPTIONS='--ignore-dir=venv --ignore-file=is:tags'
export GREP_OPTIONS='--exclude-dir=venv --exclude=tags --color=auto'
export TERM=xterm-256color

# Android
export ANDROID_HOME='/Applications/Android Studio.app/sdk'
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

### Heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# zsh-autosuggestions
source /Users/zackhsi/.zsh-autosuggestions/autosuggestions.zsh
zle-line-init() { # Enable autosuggestions automatically
zle autosuggest-start
}
zle -N zle-line-init
zmodload zsh/terminfo # zsh substring history with up/down/p/n
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
