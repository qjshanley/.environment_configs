#!/usr/bin/env bash

_doc_opts() {
    case "$@" in
        '') 
            docker --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }' \
                | { cat ; awk '$0 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc) ; } | sort
            ;;
        exec)
            local jids=( $(cat ~/.bash_temporary/jobs 2>/dev/null) )
            local dids=( $(sudo -En docker ps --format '{{.Names}}' 2>/dev/null) )
            if [ -z "${dids[@]}" ] ; then
                printf -- $'%s\n' "${jids[@]}" "${dids[@]}" | sort | uniq | awk '{print "_"$0}'
            else
                printf -- $'%s\n' "${jids[@]}" "${jids[@]}" "${dids[@]}" | sort | uniq -u
                printf -- $'%s\n' "${jids[@]}" "${dids[@]}" | sort | uniq -d | awk '{print "_"$0}'
            fi
            ;;
    esac
}

_doc_autocomplete() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[*]:1:$COMP_CWORD-1}"
  opts="$(_doc_opts "$prev")"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _doc_autocomplete doc $@
