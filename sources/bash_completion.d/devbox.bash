have devbox &&
_devbox() {
    COMPREPLY=()
    local cur prev opts cword
    _get_comp_words_by_ref cur prev words cword
    if [[ $cword -eq 1 ]]; then
      commands=$(devbox -h | tail -n+4 | awk '{print $1}')
      COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
      return 0
    fi
} &&
complete -F _devbox devbox
