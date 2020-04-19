RED='\[\e[0;31m\]'
GRE='\[\e[0;32m\]'
YEL='\[\e[0;33m\]'
BLU='\[\e[0;34m\]'
MAG='\[\e[0;35m\]'
CYA='\[\e[0;36m\]'
NO_COLOUR="\e[00m"

ITALIC='\[\e[3m\]'
BOLD='\[\e[1m\]'

SINGLE_SPACE=" "
DOUBLE_SPACE="  "
NEWLINE="\n"
PRINTING_OFF="\["
PRINTING_ON="\]"
PROMPT_COLOUR="${MAG}${BOLD}"
TIMESTAMP_COLOUR="${BOLD}"
PS1_PROMPT="\$"
PS2_PROMPT=">"
RESTORE_CURSOR_POSITION="\e[u"
SAVE_CURSOR_POSITION="\e[s"
TIMESTAMP="\A"
TIMESTAMP_PLACEHOLDER="--:--"

# https://redandblack.io/blog/2020/bash-prompt-with-updating-time/
move_cursor_to_start_of_ps1() {
  command_rows=$(history 1 | wc -l)
  if [ "$command_rows" -gt 1 ]; then
    let vertical_movement=$command_rows+1
  else
    command=$(history 1 | sed 's/^\s*[0-9]*\s*//')
    command_length=${#command}
    ps1_prompt_length=${#PS1_PROMPT}
    let total_length=$command_length+$ps1_prompt_length
    let lines=$total_length/${COLUMNS}+1
    let vertical_movement=$lines+1
  fi
  tput cuu $vertical_movement
}

__prompt() {
  PS1_ELEMENTS=(
      # Empty line after last command.
      "$EXIT_STATUS"
      "$NEWLINE"
      # First line of prompt.
      "$PRINTING_OFF" "$BOLD" "$PRINTING_ON"
      "$TIMESTAMP_PLACEHOLDER" "$PRINTING_OFF"
      "$DOUBLE_SPACE"  "$GIT_BRANCH" "$PRINTING_OFF"
      "$NO_COLOUR" "$PRINTING_ON" "$NEWLINE"
      # Second line of prompt.
      "$PRINTING_OFF" "$PROMPT_COLOUR" "$PRINTING_ON" "$PS1_PROMPT"
      "$SINGLE_SPACE" "$PRINTING_OFF" "$NO_COLOUR" "$PRINTING_ON"
  )
  PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

  PS2_ELEMENTS=(
      "$PRINTING_OFF" "$PROMPT_COLOUR" "$PRINTING_ON" "$PS2_PROMPT"
      "$SINGLE_SPACE" "$PRINTING_OFF" "$NO_COLOUR" "$PRINTING_ON"
  )
  PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")

  PS0_ELEMENTS=(
    "$SAVE_CURSOR_POSITION" "\$(move_cursor_to_start_of_ps1)"
    "$TIMESTAMP_COLOUR" "$TIMESTAMP" "$NO_COLOUR" "$RESTORE_CURSOR_POSITION"
  )
  PS0=$(IFS=; echo "${PS0_ELEMENTS[*]}")
}

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
    echo "${DOUBLE_SPACE}${YEL}${ITALIC}(${GRE}${ITALIC}$branch${YEL}${ITALIC})${NO_COLOUR}"
  fi
}

__export_git_branch() {
  GIT_BRANCH="${CYA}${BOLD}"'\W'"${YEL}$(__git_branch_fast)${NO_COLOUR}"
  export GIT_BRANCH
}

__export_exit_status() {
  local exit="$?" # Save the exit status of the last command

  # Highlight non-zero exit codes.
  if [[ $exit != 0 ]]; then
    EXIT_STATUS="${RED}${BOLD}→ Exit status: $exit${NO_COLOUR}${NEWLINE}"
  else
    EXIT_STATUS=""
  fi
  export EXIT_STATUS
}

PROMPT_COMMAND="__export_exit_status; __export_git_branch; __prompt;"
