have tmux &&
_tmux_sessions()
{
    COMPREPLY=()
    local cur prev opts cword
    _get_comp_words_by_ref cur prev words cword
    sessions=$(tmux list-sessions | awk '{print $1}' | tr -d ':$')
    if [[ $cword -eq 1 ]]; then
      COMPREPLY=( $(compgen -W "${sessions}" -- ${cur}) )
      return 0
    fi
} &&
complete -F _tmux_sessions ta tad tkss
