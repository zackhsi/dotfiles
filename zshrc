source ~/.zsh_exports
source ~/.zsh_plugins
source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases
source ~/.zsh_colorscheme
source ~/.zsh_fzf

PROJECT_DIR=/Users/zackhsi/workspace/devbox
export PATH=$PROJECT_DIR/.bin:$PATH
eval $(docker-machine env devbox || true)
