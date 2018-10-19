#!/usr/bin/env bash

DOCKER_CMD=( $(pbpaste) )
JOBID=${DOCKER_CMD[4]}

IFS='' read -r -d '' SCRIPT <<- EOF
touch ~/.bash_temporary
if [ -z "\$(grep "^alias dexec_${JOBID}" ~/.bash_temporary)" ] ; then
    printf -- $'alias dexec_${JOBID}=\'screen -t ${JOBID} sudo docker exec -it \$@ $JOBID bash -c "TERM=xterm EDITOR=vim VISUAL=vim PSQL_EDITOR=\$(which vim) bash -o vi"\'\n' >> ~/.bash_temporary
fi

exec "\$SHELL" --login -c 'screen -U -DR -S ssh -t host -p 0 ; logout'
EOF

# copy dot files to server
rsync -Le ssh \
    ~/.bash_profile \
    ~/.bash_aliases \
    ~/.bash_logout \
    ~/.bashrc \
    ~/.screenrc \
    ~/.vimrc \
    "$1":~/. >/dev/null 2>&1

# ssh to server and attach directly to a screen session
ssh -t "$1" "$SCRIPT"

