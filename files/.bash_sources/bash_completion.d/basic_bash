#!/usr/bin/env bash

_basic_bash_opts() {
    cmds "$(which $1)" "${2:-main}"
}

_basic_bash_autocomplete() {
    local cmd= cur= last= prev= opts=
    COMPREPLY=()
    local cmd="${COMP_WORDS[@]:0:1}"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev=( "${COMP_WORDS[@]:1:${COMP_CWORD}-1}" )
    local last="${prev[@]:${#prev[@]}-1}"
    local opts="$(_basic_bash_opts "$cmd" "$last")"
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    return 0
}

for script in $( /usr/bin/find ~/.bash_scripts -mindepth 1 -maxdepth 1 \( -type l -or -type f \) -perm +755 -exec basename {} \; ) ; do
    complete -F _basic_bash_autocomplete $script "$@"
done
