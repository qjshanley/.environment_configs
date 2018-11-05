# .bashrc
# -----------------------------------------
# Read everytime a new subshell is invoked.

# Set PATH Variable
BINS=(
    ~/.bin
    /usr/local/go/bin
    ~/code/go/bin
    ~/Library/Python/2.7/bin
)
for bin in "${BINS[@]}" ; do
	test -d "$bin" -a -z "$(echo "$PATH" | grep "$bin")" && PATH+=":${bin}"
done
export "PATH=$PATH"

# Set Environment Variables
EVARS=(
    EDITOR=vim
    VISUAL=vim
    TERM=xterm-256color
    GOROOT=/usr/local/go
    GOPATH=~/code/go
    PSQL_EDITOR=$(which vim)
    STACKS=~/code/docker/doc
    STACK=pod-browser
)
for evar in "${EVARS[@]}" ; do eval " export $evar" ; done

# Set Shell Variables
test -x /usr/local/bin/bash && export SHELL=/usr/local/bin/bash
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# source files
SOURCES=( ~/.bash_aliases ~/.bash_autocomplete )
for src in "${SOURCES[@]}" ; do
    # source single files
    test -f "$src" && source "$src"
    # source full directories
    if test -d "$src" && test ! -z "$(ls -A "$src")" ; then
        for file in "$src"/* ; do source "$file" ; done
    fi
done
