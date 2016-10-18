have docker &&
_control() {
    COMPREPLY=()
    local cur prev opts cword
    _get_comp_words_by_ref cur prev words cword
    if [[ $cword -eq 2 ]]; then
      if [[ "$prev" == "kill" ]]; then
        running_containers=$(docker ps --format "{{.Names}}")
        COMPREPLY=( $(compgen -W "${running_containers}" -- ${cur}) )
        return 0
      fi
    fi
} &&
complete -F _control control c
