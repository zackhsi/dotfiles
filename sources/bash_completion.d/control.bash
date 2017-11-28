have docker && have control &&
_control() {
    COMPREPLY=()
    local cur prev cword
    _get_comp_words_by_ref cur prev words cword
    if [[ $cword -eq 1 ]]; then
      # control -h | sed -n '/for detailed help/,$p' | tail -n+2 | awk '{print $1}'
      read -rd '' commands << EOF
ancestors
build
check
clean
deploy
descendants
disconnect
disconnects
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
register-host
replicate-images
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
tethered
update
url
version
EOF
      COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
      return 0
    elif [[ $cword -eq 2 ]]; then
      if [[ "$prev" =~ enter|kill|restart|stop ]]; then
        running_containers=$("$SRC/devbox/bin/devbox-ssh-fast" sudo docker ps --format "{{.Names}}" | tr -d '\r')
        COMPREPLY=( $(compgen -W "$running_containers" -- "$cur") )
        return 0
      fi
    fi
} &&
complete -F _control control c
