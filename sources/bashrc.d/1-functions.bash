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

###############################################################################
# AWS
###############################################################################

# term i-d2609352
term() {
  aws ec2 terminate-instances --instance-ids "$@"
}

describe() {
  xargs -P 50 -I % aws ec2 describe-instances --instance-ids %
}

summarize() {
  jq '.Reservations[0].Instances[0]' | jq '.InstanceId, .State.Name, .InstanceType'
}

itype() {
  jq '.Reservations[0].Instances[0].InstanceType'
}

state() {
  jq '.Reservations[0].Instances[0].State.Name'
}

# ASG functions
asg_ssh() {
  aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "$1" \
    | jq -r ".AutoScalingGroups[0].Instances | .[].InstanceId" \
    | cut -d- -f2 \
    | xargs -I % tmux split-window "tmux select-layout tiled && TERM=screen-16color $(alias ssh | cut -d= -f2) -oStrictHostKeyChecking=no %.ln"
}
asg_term_decrement() {
  aws autoscaling terminate-instance-in-auto-scaling-group --instance-id $1 --should-decrement-desired-capacity
}
asg_term_no_decrement() {
  aws autoscaling terminate-instance-in-auto-scaling-group --instance-id $1 --no-should-decrement-desired-capacity
}
asg_ls() {
  aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "$1" \
    | jq --raw-output ".AutoScalingGroups[0].Instances | .[].InstanceId" \
    | sort
}
asg_ll() {
  aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "$1" \
    | jq ".AutoScalingGroups[0].Instances | .[]"
}

# https://news.ycombinator.com/item?id=12296000
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;35m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
