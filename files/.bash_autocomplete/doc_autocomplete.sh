#!/usr/bin/env bash

_doc_opts() {
    local stack="$(doc ls -C "$1")"
    [ "$stack" == "$1" ] && shift 1
    case "$1" in
        '') 
            if [ ! -e /tmp/doc/commands ] ; then
                mkdir -p /tmp/doc
                {
                    docker-compose  --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }'
                    awk '$3 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc)
                } | sort | uniq > /tmp/doc/commands
            fi
            cat /tmp/doc/commands
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
                doc "$stack" ls --services
                printf -- "%s\n" "$@" "$@"
            } | sort | uniq -u
            ;;
    esac
}

_doc_autocomplete() {
    local cur= prev= opts=
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev=( ${COMP_WORDS[@]:1:$COMP_CWORD-1} )
    if [ "${#prev[@]}" == "0" ] ; then 
        if [ "$cur" ] ; then
            [ "$STACK" ] && local opts="$(compgen -W "$(doc ls)" -- "$cur")" || local opts="$(doc ls)"
        else
            [ "$STACK" ] || local opts="$(doc ls)"
        fi
    fi
    local opts="${opts:-"$(_doc_opts "${prev[@]}")"}"
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    return 0
}

complete -F _doc_autocomplete doc "$@"
