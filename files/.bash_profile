# .bash_profile
# ----------------------------
# Read once by the login shell

# Set Environment Variables
export EDITOR=vim
export VISUAL=vim
export TERM=xterm-256color
test -x /usr/local/bin/bash && export SHELL=/usr/local/bin/bash

# Set PATH Variable
BINS=( /usr/local/bin ~/.bin /usr/local/go/bin ~/code/go/bin ~/Library/Python/2.7/bin )
for bin in "${BINS[@]}" ; do
  test -d "$bin" -a -z "$(echo "$PATH" | grep "$bin")" && PATH+=":${bin}"
done
export "PATH=$PATH"

# Set Golang Variables
GODIRS=( GOROOT=/usr/local/go GOPATH=~/code/go )
for dir in "${GODIRS[@]}" ; do eval " export $dir" ; done

