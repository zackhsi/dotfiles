prompt_command() {
  PREFIX="\x1B"
  COLOR_OFF="$PREFIX[0m"
  RED="$PREFIX[0;31m"
  GREEN="$PREFIX[0;32m"
  YELLOW="$PREFIX[0;33m"
  MAGENTA="$PREFIX[0;35m"

  echo 'PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'
}
PROMPT_COMMAND=$(prompt_command)
