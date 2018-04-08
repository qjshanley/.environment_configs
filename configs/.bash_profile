# .bash_profile
# ----------------------------
# Read once by the login shell

# set environment variables
[ -d /usr/local/bin ] && [ -z "$(echo $PATH | grep /usr/local/bin)"  ] && export PATH=${PATH}:/usr/local/bin
[ -f /usr/local/bin/bash ] && export SHELL=/usr/local/bin/bash

# Golang
[ -d /usr/local/go/bin ] && [ -z "$(echo $PATH | grep /usr/local/go/bin)" ] && export PATH=${PATH}:/usr/local/go/bin
export GOROOT=/usr/local/go
export GOPATH=~/code/go
export GOBIN=~/code/go/bin

# aliases and functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source autocompletion scripts
[ -d ~/.bash_autocomplete ] && for script in $(ls -A ~/.bash_autocomplete/*) ; do source $script ; done
