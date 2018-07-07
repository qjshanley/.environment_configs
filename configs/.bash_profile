# .bash_profile
# ----------------------------
# Read once by the login shell

EDITOR=vim
VISUAL=vim
set -o vi

# set environment variables
BINS=( /usr/local/bin ~/.bin /usr/local/go/bin ~/code/go/bin ~/Library/Python/2.7/bin )
for bin in "${BINS[@]}" ; do
  [ -d "$bin" -a -z "$(echo "$PATH" | grep "$bin")" ] && PATH+=":${bin}"
done
export "PATH=$PATH"

# set SHELL to local bash if it exists
[ -x /usr/local/bin/bash ] && export SHELL=/usr/local/bin/bash

# Golang
GODIRS=( GOROOT=/usr/local/go GOPATH=~/code/go )
for dir in "${GODIRS[@]}" ; do eval " export $dir" ; done

SOURCES=( ~/.bash_aliases ~/.bash_autocomplete )
for src in "${SOURCES[@]}" ; do
	# source single files
	[ -f "$src" ] && source "$src"
	# source full directories
	[ -d "$src" -a ! -z "$(ls -A "$src")" ] && for file in "$src"/* ; do source "$file" ; done
done

