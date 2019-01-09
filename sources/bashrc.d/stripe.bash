[ -f ~/stripe/password-vault/bash_completion ] && . ~/stripe/password-vault/bash_completion
[ -x ~/stripe/space-commander/bin/sc-ssh-wrapper ] && alias ssh="TERM=xterm-color sc-ssh-wrapper"

export PATH="~/stripe/henson/bin:$PATH"
export PATH="~/stripe/password-vault/bin:$PATH"
export PATH="~/stripe/space-commander/bin:$PATH"

export SC_AWS_ROLE_NAME=access-s3-stripe-data

alias pay="TERM=xterm-color pay"
