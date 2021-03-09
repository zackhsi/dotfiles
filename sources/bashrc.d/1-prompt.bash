# Configure PS0, PS1, and PS2.
#
# Dynamically generates via PROMPT_COMMAND:
# - Timestamp that previous command ran [0].
# - Exit status of previous command if nonzero.
# - Git branch (fast).
#
# [0] From: https://redandblack.io/blog/2020/bash-prompt-with-updating-time/

RED='\[\e[0;31m\]'
GRE='\[\e[0;32m\]'
YEL='\[\e[0;33m\]'
BLU='\[\e[0;34m\]'
MAG='\[\e[0;35m\]'
CYA='\[\e[0;36m\]'
NO_COLOR='\[\e[0m\]'

ITALIC='\[\e[3m\]'
BOLD='\[\e[1m\]'

SINGLE_SPACE=" "
DOUBLE_SPACE="  "
NEWLINE="\n"
PROMPT_COLOR="${MAG}${BOLD}"
TIMESTAMP_COLOR="${BOLD}"
PS1_PROMPT="\$"
PS2_PROMPT=">"
RESTORE_CURSOR_POSITION="\e[u"
SAVE_CURSOR_POSITION="\e[s"
TIMESTAMP="\A"
DIRECTORY='\w'
TIMESTAMP_PLACEHOLDER="--:--"

move_cursor_to_start_of_ps1() {
  command_rows=$(history 1 | wc -l)
  if [ "$command_rows" -gt 1 ]; then
    vertical_movement=$(( command_rows + 1 ))
  else
    command=$(history 1 | sed 's/^\s*[0-9]*\s*//')
    command_length=${#command}
    ps1_prompt_length=${#PS1_PROMPT}
    total_length=$(( command_length + ps1_prompt_length ))
    lines=$(( total_length / COLUMNS + 1))
    vertical_movement=$(( lines + 1 ))
  fi
  tput cuu $vertical_movement
}

__prompt() {
  PS1_ELEMENTS=(
    # Previous command's exit status.
    "$EXIT_STATUS"
    # Empty line after last command.
    "$NEWLINE"
    # First line of prompt.
    "$BOLD"
    "$TIMESTAMP_PLACEHOLDER" "$DOUBLE_SPACE"
    "$BLU" "$BOLD" "$DIRECTORY" "$DOUBLE_SPACE"
    "$GIT_BRANCH"
    "$NO_COLOR" "$NEWLINE"
    # Second line of prompt.
    "$PROMPT_COLOR" "$PS1_PROMPT"
    "$SINGLE_SPACE" "$NO_COLOR"
  )
  PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

  PS2_ELEMENTS=(
    "$PROMPT_COLOR" "$PS2_PROMPT"
    "$SINGLE_SPACE" "$NO_COLOR"
  )
  PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")

  PS0_ELEMENTS=(
    "$SAVE_CURSOR_POSITION" "\$(move_cursor_to_start_of_ps1)"
    "$TIMESTAMP_COLOR" "$TIMESTAMP" "$NO_COLOR" "$RESTORE_CURSOR_POSITION"
  )
  PS0=$(IFS=; echo "${PS0_ELEMENTS[*]}")
  export PS0
}

__compute_git_branch_fast() {
  local head=""
  local gitdir=""
  local cur="$PWD"
  while [[ -n "$cur" ]]; do
    if [[ -e "$cur/.git" ]]; then
      gitdir="$cur/.git"
      break
    fi
    cur="${cur%/*}"
  done
  [ -f "$gitdir/HEAD" ] && read -r head < "$gitdir/HEAD"
  case "$head" in
    ref:*)
      branch="${head##ref: refs/heads/}"
      ;;
    "")
      branch=""
      ;;
    *)
      branch="d:${head:0:7}"
      ;;
  esac
  if [ -n "$branch" ]; then
    GIT_BRANCH="${YEL}${ITALIC}(${CYA}${ITALIC}$branch${YEL}${ITALIC})${NO_COLOR}"
  else
    GIT_BRANCH=""
  fi
}

__compute_exit_status() {
  local exit="$?"

  # Highlight non-zero exit codes.
  if [[ $exit != 0 ]]; then
    EXIT_STATUS="${RED}${BOLD}→ Exit status: $exit${NO_COLOR}${NEWLINE}"
  else
    EXIT_STATUS=""
  fi
}

# __compute_exit_status must be called first to save the previous exit status.
PROMPT_COMMAND="__compute_exit_status; __compute_git_branch_fast; __prompt; history -n; history -w; history -c; history -r;"
