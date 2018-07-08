#!/usr/bin/env bash

_hosts() {
  [ -f ~/.ssh/known_hosts ] && grep '^[a-z|A-Z]' ~/.ssh/known_hosts | awk '{print $1}'
}

_ssh_autocomplete() 
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="$(_hosts)"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  [ -z "$COMPREPLY" ] && opts="$(ls -A)" && COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _ssh_autocomplete scp
complete -F _ssh_autocomplete ssh
