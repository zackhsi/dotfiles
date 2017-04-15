GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true


__set_bash_prompt()
{
  local exit="$?" # Save the exit status of the last command

  # PS1 is made from $PreGitPS1 + <git-status> + $PostGitPS1
  local PreGitPS1=""
  local PostGitPS1=""

  # Wrap the colour codes between \[ and \], so that
  # bash counts the correct number of characters for line wrapping:
  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local Yel='\[\e[0;33m\]'
  local Blu='\[\e[0;34m\]'
  local Mag='\[\e[0;35m\]'
  local Cya='\[\e[0;36m\]'
  local Whi='\[\e[0;37m\]'
  local None='\[\e[0m\]' # Return to default colour

  PreGitPS1+="$Mag\W$None"

  # Virtualenv
  if [ -n "$VIRTUAL_ENV" ]; then
    PostGitPS1+=" ($(basename $VIRTUAL_ENV))"
  fi

  # Highlight non-standard exit codes
  if [[ $exit != 0 ]]; then
    PostGitPS1=" $Red[$exit]"
  fi

  if [[ $exit == 0 ]]; then
    PostGitPS1+="$Blu"' $ '"$None"
  else
    PostGitPS1+="$Red"' $ '"$None"
  fi

  # Set PS1 from $PreGitPS1 + <git-status> + $PostGitPS1
  __git_ps1 "$PreGitPS1" "$PostGitPS1" ' (%s)'
}

# This tells bash to reinterpret PS1 after every command, which we
# need because __git_ps1 will return different text and colors
PROMPT_COMMAND="__set_bash_prompt; $PROMPT_COMMAND"
