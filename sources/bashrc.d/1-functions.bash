###############################################################################
# Python
###############################################################################
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
# Git
###############################################################################

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
