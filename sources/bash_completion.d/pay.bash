have pay &&
_stripe_repos()
{
    COMPREPLY=()
    local cur prev opts cword
    _get_comp_words_by_ref cur prev words cword
    repos=$(ls ~/stripe/)
    if [[ $cword -eq 1 ]]; then
      COMPREPLY=( $(compgen -W "${repos}" -- ${cur}) )
      return 0
    fi
} &&
complete -F _stripe_repos pay-sync
