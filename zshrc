source ~/.zsh_exports
source ~/.zsh_plugins
source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases
source ~/.zsh_colorscheme
source ~/.zsh_fzf

# Devbox
PROJECT_DIR=$(awk -F "=" '/project_dir/ {print $2}' ~/.devbox | tr -d " ")
export PATH=$PROJECT_DIR/.bin:$PATH
export DOCKER_HOST="tcp://$(awk -F "=" '/ip_address/ {print $2}' ~/.devbox | tr -d " "):2375"
