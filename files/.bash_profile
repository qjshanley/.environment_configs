# .bash_profile
# ----------------------------
# Read once by the login shell

# Set PATH Variable
BINS=( ~/.bin /usr/local/go/bin ~/code/go/bin ~/Library/Python/2.7/bin )
for bin in "${BINS[@]}" ; do
	test -d "$bin" -a -z "$(echo "$PATH" | grep "$bin")" && PATH+=":${bin}"
done
export "PATH=$PATH"

# Set PATH Variable
#if [ -z "$(printenv PATH | grep "^/usr/local/bin")" ] ; then
#	export "PATH=/usr/local/bin:${PATH}:~/.bin:/usr/local/go/bin:~/code/go/bin:~/Library/Python/2.7/bin"
#fi

# Set Environment Variables
EVARS=( 
	EDITOR=vim
	VISUAL=vim
	TERM=xterm-256color
	GOROOT=/usr/local/go 
	GOPATH=~/code/go 
)
for evar in "${EVARS[@]}" ; do eval " export $evar" ; done

# Set Shell Variables
test -x /usr/local/bin/bash && export SHELL=/usr/local/bin/bash

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
	test -r "$config" && mv "$config" "${config}.disable"
done

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

