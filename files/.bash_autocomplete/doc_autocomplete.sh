#!/usr/bin/env bash

_doc_opts() {
    local stack
    _get_stacks() { find -E $STACKS -mindepth 1 -maxdepth 1 -type d -regex ".*/[^/.]*" -exec basename {} \; ; }
    case "$#" in
        0)
            _get_stacks ;;
        *)
            stack=$(compgen -W "$(_get_stacks)" -- "$1")
            [ -z "$stack" ] && stack="${STACK:?This environment variable needs to be defined.}" || shift 1
            ;;
    esac

    case "$1" in
        '') 
            {
                docker-compose  --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }'
                awk '$3 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc)
            } | sort | uniq
            ;;
        down|ls) ;;
        exec|stats)
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

complete -F _doc_autocomplete doc $@
