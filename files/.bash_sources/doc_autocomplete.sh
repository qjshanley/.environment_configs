#!/usr/bin/env bash

_doc_opts() {
    local stack="$(doc utils --check-stack "$1")"
    [ "$stack" == "$1" ] && shift 1
    case "$1" in
        '') 
            if [ ! -e "$(find /tmp/doc/ -name commands -mtime 0)" ] ; then
                mkdir -p /tmp/doc
                {
                    docker-compose  --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }'
                    awk '$3 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc)
                } | sort | uniq > /tmp/doc/commands
                echo utils >> /tmp/doc/commands
            fi
            cat /tmp/doc/commands
            ;;
        down) ;;
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
                doc "$stack" utils --services
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

    if [ "$STACKS" ] ; then
        # the STACKS variable exists and we can proceed.
        if [ "${#prev[@]}" == "0" ] ; then
            # no previous words found. we are completing a path. return stack options.
            local opts="$(doc utils --stacks)"
        else
            # previous words found. we are completing docker arguments.
            local opts="$(_doc_opts "${prev[@]}")"
        fi
    else
        # the STACKS variable doesn't exist.
        echo ; echo The STACKS environment variable needs to be defined.
    fi
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    return 0
}

complete -F _doc_autocomplete doc "$@"
