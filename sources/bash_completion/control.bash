have docker && have control &&
_control() {
    COMPREPLY=()
    local cur prev opts cword
    _get_comp_words_by_ref cur prev words cword
    if [[ $cword -eq 1 ]]; then
      # control -h | sed -n '/for detailed help/,$p' | tail -n+2 | awk '{print $1}'
      read -d '' commands << EOF
ancestors
build
check
clean
deploy
descendants
discover
ensure
enter
extract
function
kill
list
manifest
override
present
provision
pull
push
release
reset
restart
run
snapshot
start
stats
status
stop
test
update
url
version
EOF
      COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
      return 0
    elif [[ $cword -eq 2 ]]; then
      if [[ "$prev" =~ enter|kill|restart ]]; then
        running_containers=$(docker ps --format "{{.Names}}")
        COMPREPLY=( $(compgen -W "${running_containers}" -- ${cur}) )
        return 0
      fi
    fi
} &&
complete -F _control control c
