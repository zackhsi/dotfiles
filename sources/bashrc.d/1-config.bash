###############################################################################
# Coreutils                                                                   #
###############################################################################
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

###############################################################################
# Directories                                                                 #
###############################################################################
alias d="cd ~/Desktop"
alias dot="cd ~/dotfiles"
alias oss="cd ~/oss"
alias s="cd ~/stripe"

###############################################################################
# Dotfiles                                                                    #
###############################################################################
export PATH=~/dotfiles/bin:$PATH

###############################################################################
# Fuck                                                                        #
###############################################################################
alias fk=fuck
eval "$(thefuck --alias)"

###############################################################################
# FZF                                                                         #
###############################################################################
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*" --glob "!bazel-bin/*" --glob "!.ijwb/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--color 16,bg+:0,fg+:3,hl:6,hl+:6 --bind up:preview-up,down:preview-down'
export FZF_CTRL_R_OPTS='--sort'
# shellcheck source=/Users/zackhsi/.fzf.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

###############################################################################
# Git                                                                         #
###############################################################################
alias g='git'
__git_complete g __git_main
alias gb='git branch'
__git_complete gb _git_branch
alias gbc="git branch | grep -v master | xargs git branch -d"
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbDa="git for-each-ref --format '%(refname:short)' refs/heads | grep -v master | xargs git branch -D"
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gcount='git shortlog -sn'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcm='git checkout master'
alias gco='git checkout'
__git_complete gco _git_checkout
alias gd='git diff'
__git_complete gd _git_diff
alias gdm='git diff master'
alias gds='git diff --staged'
alias gdt='git difftool'
__git_complete gdt _git_diff
alias gl='git pull'
alias glg='git log --stat'
__git_complete glg _git_log
gp() {
  if [[ $# -gt 0 ]]; then
    git push "$@"
  else
    git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)"
  fi
}
# Push branch, create pull request, browse.
p() {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  base_commit=$(git merge-base master "$branch_name")
  num_commits=$(git rev-list --count "$base_commit".."$branch_name")
  git push --set-upstream origin "$branch_name"
  if [[ "$num_commits" == "1" ]] && ! [ -f .github/PULL_REQUEST_TEMPLATE.md ]; then
    hub pull-request --browse --no-edit "$@"
  else
    hub pull-request --browse "$@"
  fi
}
alias grb='git rebase'
__git_complete grb _git_rebase
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbm='git rebase master'
grev() {
  if [[ $# -gt 0 ]]; then
    git rev-parse "$@"
  else
    git rev-parse HEAD
  fi
}
alias gst='git status'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip--"'

###############################################################################
# Golang                                                                      #
###############################################################################
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

###############################################################################
# Grep                                                                        #
###############################################################################
export GREP_OPTIONS='--exclude-dir=venv --color=auto'

###############################################################################
# Homebrew                                                                    #
###############################################################################
export PATH=/usr/local/sbin:$PATH

###############################################################################
# Hub                                                                         #
###############################################################################
alias hc='hub compare'
alias pr="hub pull-request"

###############################################################################
# Ls                                                                          #
###############################################################################
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"

###############################################################################
# Neovim                                                                      #
###############################################################################
alias v=nvim
alias vi=nvim
alias vim=nvim
alias view='nvim -R'

###############################################################################
# Node                                                                        #
###############################################################################
export PATH=~/dotfiles/node_modules/.bin:$PATH

###############################################################################
# Python                                                                      #
###############################################################################
export PYTHONDONTWRITEBYTECODE=1
venv() {
  virtualenv venv
  source venv/bin/activate
}
venv3() {
  python3 -m venv venv
  source venv/bin/activate
}
pyc() {
  find . -name "*.pyc" -delete
}

###############################################################################
# Rust                                                                        #
###############################################################################
export PATH=$HOME/.cargo/bin:$PATH

###############################################################################
# Scala                                                                       #
###############################################################################
export PATH=/usr/local/opt/scala@2.11/bin:$PATH

###############################################################################
# Shellcheck                                                                  #
###############################################################################
export SHELLCHECK_OPTS="-e SC1091"

###############################################################################
# TERM                                                                        #
###############################################################################
export TERM=xterm-256color-italic

###############################################################################
# Tig                                                                         #
###############################################################################
alias tst='tig status'
stty dsusp undef  # Scroll up with <C-y> https://github.com/jonas/tig/issues/214.

###############################################################################
# Tmux                                                                        #
###############################################################################
alias tmux='tmux -u'
alias ta='tmux -u attach -t'
alias tad='tmux -u attach -d -t'
alias ts='tmux -u new-session -s'
alias tl='tmux -u list-sessions'
alias tksv='tmux -u kill-server'
alias tkss='tmux -u kill-session -t'
