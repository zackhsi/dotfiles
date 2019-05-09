export PATH=$HOME/stripe/henson/bin:$PATH
export PATH=$HOME/stripe/password-vault/bin:$PATH
export PATH=$HOME/stripe/space-commander/bin:$PATH

[ -f ~/stripe/password-vault/bash_completion ] && . ~/stripe/password-vault/bash_completion
[ -x ~/stripe/space-commander/bin/sc-ssh-wrapper ] && alias ssh="TERM=xterm-color sc-ssh-wrapper"

export SC_AWS_ROLE_NAME=engineersreadonly

alias pay="TERM=xterm-color pay"

ssh-service() {
  ssh "$(ls-servers -Spt "$1" --sample-user -N)"
}
alias opsbox="ssh-service opsbox"
alias runway="ssh-service runway"
