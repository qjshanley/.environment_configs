# .bash_profile
# ----------------------------
# Read once by the login shell

# set environment variables
bins="/usr/local/bin ${HOME}/.bin /usr/local/go/bin ${HOME}/code/go/bin"
for bin in $bins ; do
  [ -d $bin ] && [ -z "$(echo $PATH | grep $bin)" ] && export PATH=${PATH}:${bin}
done
[ -f /usr/local/bin/bash ] && export SHELL=/usr/local/bin/bash

# Golang
export GOROOT=/usr/local/go
export GOPATH=~/code/go

# aliases and functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source autocompletion scripts
[ -d ~/.bash_autocomplete ] && for script in $(ls -A ~/.bash_autocomplete/*) ; do source $script ; done
