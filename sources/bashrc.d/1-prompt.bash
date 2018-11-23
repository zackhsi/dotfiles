__git_branch_fast() {
  local gitdir=""
  local cur="$PWD"
  while [[ ! -z "$cur" ]]; do
    if [[ -e "$cur/.git" ]]; then
      gitdir="$cur/.git"
      break
    fi
    cur="${cur%/*}"
  done
  [ -f "$gitdir/HEAD" ] && read -r head < "$gitdir/HEAD"
  case "$head" in
    ref:*)
      branch="${head##*/}"
      ;;
    "")
      branch=""
      ;;
    *)
      branch="d:${head:0:7}"
      ;;
  esac
  if [ -n "$branch" ]; then
    echo " ($branch)"
  fi
}


__set_bash_prompt() {
  local exit="$?" # Save the exit status of the last command

  local RED='\[\e[0;31m\]'
  local GRE='\[\e[0;32m\]'
  local YEL='\[\e[0;33m\]'
  local BLU='\[\e[0;34m\]'
  local MAG='\[\e[0;35m\]'
  local CYA='\[\e[0;36m\]'
  local WHI='\[\e[0;37m\]'
  local BOLD='\[\e[1m\]'
  local NONE='\[\e[0m\]'

  # Highlight non-standard exit codes
  if [[ $exit != 0 ]]; then
    EXIT_STATUS=" ${RED}${BOLD}[$exit]"
  else
    EXIT_STATUS="$MAG$BOLD"
  fi
  PS1="${CYA}${BOLD}"'\W'"${YEL}$(__git_branch_fast)""${EXIT_STATUS}"' $ '"$NONE"

  export PS1
}

PROMPT_COMMAND="__set_bash_prompt; history -n; history -w; history -c; history -r;"
