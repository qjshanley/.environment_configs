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

# vim style cmd line editing
set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=1000000

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x "$(which dircolors)" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
