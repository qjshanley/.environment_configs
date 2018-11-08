#!/usr/bin/env bash

_doc_opts() {
    local stack
    if [ "$#" -eq "0" ] ; then
        [ -z "$STACK" ] && { find -E $STACKS -mindepth 1 -maxdepth 1 -type d -regex ".*/[^/.]*" -exec basename {} \; ; return 0 ; }
        stack=$STACK
    else
        stack="$(compgen -W "$(doc ls)" -- "$1" | head -1)"
        [ "$stack" == "$1" ] && shift 1 || stack="${STACKS:-$(doc ls | head -1)}"
    fi
    case "$1" in
        '') 
            {
                docker-compose  --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }'
                awk '$3 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc)
            } | sort | uniq
            ;;
        down|ls) ;;
        stats)
            shift 1
            {
                docker ps --format '{{.Names}}'
                printf -- "%s\n" "$@" "$@"
            } | sort | uniq -u
            ;;
        *)
            shift 1
            {
                doc "$stack" ps --services
                printf -- "%s\n" "$@" "$@"
            } | sort | uniq -u
            ;;
    esac
}

_doc_autocomplete() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev=( ${COMP_WORDS[@]:1:$COMP_CWORD-1} )
  opts="$(_doc_opts "${prev[@]}")"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _doc_autocomplete doc "$@"
