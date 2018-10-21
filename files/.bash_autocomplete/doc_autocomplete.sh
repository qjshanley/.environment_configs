#!/usr/bin/env bash

_doc_opts() {
    case "$@" in
        '') 
            doc $@ --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }' \
                | { awk '$3 ~ /^_doc_/ { split($0, cmd, "_") ; print cmd[3] }' $(which doc) ; cat ; } | sort
            ;;
        exec)
            doc ps --services
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
