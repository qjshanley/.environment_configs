#!/usr/bin/env bash

HOST=$1
DOCKER_CMD=( $(pbpaste) )
JOBID=${DOCKER_CMD[4]}

IFS='' read -r -d '' SCRIPT <<- EOF
	if [ -z "\$(grep "^alias dexec_${JOBID}")" ] ; then
		printf -- '%s\n' 'alias dexec_${JOBID}="sudo docker exec -it -e TERM=xterm -e EDITOR=vim -e VISUAL=vim $JOBID bash -o vi"' >> ~/.bash_temporary
	fi

	screen -S ssh -X screen -t $JOBID
	if [ "\$?" != "0" ] ; then
	  screen -dmS ssh -t host
	  screen -r ssh -X screen -t $JOBID
	fi
	screen -U -DR -S ssh -p $JOBID
EOF

printf -v SSH_SCREEN -- '%q' "$SCRIPT"

# copy dot files to server
rsync -Le ssh \
	~/.bash_profile \
	~/.bash_aliases \
	~/.bash_logout
	~/.bashrc \
	~/.screenrc \
	~/.vimrc \
	"$HOST":~/. >/dev/null 2>&1

# ssh to server and attach directly to a screen session
ssh -t "$HOST" "$SCRIPT"

