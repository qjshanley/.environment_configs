#! /usr/bin/env bash

_hosts() {
  local known_hosts
  ssh_configs=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* | grep -v '[?*]' | cut -d ' ' -f 2-)
  known_hosts=$(cut -d ' ' -f 1 ~/.ssh/known_hosts)
  echo $ssh_configs $known_hosts | tr ' ' '\n' | grep '^[a-z|A-Z]'
}

_ssh_autocomplete() 
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="$(_hosts)"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _ssh_autocomplete ssh
