# .bash_profile
# ----------------------------
# Read once by the login shell

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

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
	test -r "$config" && mv "$config" "${config}.disable"
done

test -f ~/.bashrc && source ~/.bashrc

