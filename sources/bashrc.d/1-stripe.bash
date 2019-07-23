export PATH=$HOME/stripe/henson/bin:$PATH
export PATH=$HOME/stripe/password-vault/bin:$PATH
export PATH=$HOME/stripe/space-commander/bin:$PATH
export PATH=$HOME/stripe/pay-server/manage/frontend/node_modules/.bin:$PATH

[ -f ~/stripe/password-vault/bash_completion ] && . ~/stripe/password-vault/bash_completion
[ -x ~/stripe/space-commander/bin/sc-ssh-wrapper ] && alias ssh="TERM=xterm-color sc-ssh-wrapper"

alias pay="TERM=xterm-color pay"

ssh-service() {
  ssh "$(ls-servers -Spt "$1" --sample-user -N)"
}
alias opsbox="ssh-service opsbox"
alias runway="ssh-service runway"

# Fix messages of "WARNING: Nokogiri was built against LibXML version 2.9.9, but has dynamically loaded 2.9.4".
alias nokogiri-fix="gem install nokogiri -- --use-system-libraries"

# Stripe git wrapper is slow and messes up IO (cannot pipe git log -G to tig).
unalias git
