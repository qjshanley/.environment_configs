#!/usr/bin/env bash

_doc_opts() {
    case "$@" in
        '') 
            doc $@ --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }' \
                | { cat ; awk '$0 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc) ; } | sort
            ;;
        exec)
            local jobs=~/.bash_temporary/jobs
            if [ -e "$jobs" ] ; then
                { cat "$jobs" ; cat "$jobs" ; doc ps --format '{{.Names}}' ; } \
                    | sort | uniq -u \
                    | { { cat "$jobs" ; doc ps --format '{{.Names}}' ; } | sort | uniq -d | awk '{print "_"$0}' ; cat ; } \
                    | sort
            else
                doc ps --format '{{.Names}}'
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
