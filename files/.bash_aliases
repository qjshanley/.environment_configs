# User specific aliases and functions
alias ..='cd ..'
alias vi='vim -o'
alias lh='ls -lh'
alias lt='ls -lt'
alias lha='ls -lhA'
alias lta='ls -ltA'
alias recent='ls -lhtA | head -n 20'
alias line='printf -- "%*s\n" "$(tput cols)" " " | sed "s/ /-/g"'
alias renew='exec $SHELL --login'

# enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

function _is_linux { uname -s | sed 's/Darwin//g' ; }

function compare { diff -W $(tput cols) -s -y $@ ; }

function LIST { netstat -an | sed -n '1,2p ; /^tcp.*LISTEN/p' ; }

function dat { bash ~/code/datica/toolbox/misc/exec_for_each_service_in_env.sh $@ ; }

function pod-api {
    sudo -E docker exec -it -u postgres postgresql bash -c '
        PSQL_EDITOR=$(which vim)
        PG_CURR_DB=pod-api
        psql $PG_CURR_DB
    '
}

function shh { 
    if [ "$#" == 1 -a "${1:0:1}" != "-" ] ; then

        # touch the known_hosts file if it doesn't exist
        test ! -e ~/.ssh/known_hosts && mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

        # copy dot files to server
        rsync -Le ssh \
            ~/.bashrc \
            ~/.bash_aliases \
            ~/.bash_logout \
            ~/.bash_profile \
            ~/.screenrc \
            ~/.vimrc \
            "$1":~/. >/dev/null 2>&1

        # ssh to server and attach directly to a screen session
        ssh -t "$1" 'exec "$SHELL" -l -c "screen -U -DR -S ssh -p 0 -t host ; logout"'
    else
        # simply pass all args to the ssh command
        ssh "$@"
    fi
}


function ppass { 
    while true ; do
        read -esp "Password: " p1 && printf -- $'\n'
        read -esp "Confirm password: " p2 && printf -- $'\n'
        [ -n "$p1" -a "$p1" == "$p2" ] && break || printf -- $'Passwords were blank or did not match. Please try again.\n'
    done
    printf -- "$p1"
}

function rpass {
    local n=
    if [ -z "$1" ] ; then
        n=32
    else
        [ "$1" -eq "$1" ] && n="$1" 2>/dev/null || return 1
    fi
    PASSWORD=$(openssl rand "$n" | base64 -w 0 | cut -c "1-$n")
    printf -- 'Generated the random password: %s\n' "$PASSWORD" > /dev/tty
    printf -- "$PASSWORD" > /dev/stdout
}

function eztar {
    object="$(basename $1)"
    [ -e "$object" ] || printf -- "Object (${object}) must exist in your current directory: $?"
    if [ "$(rev <<< "$object" | cut -d '.' -f 1 | rev)" == "enc" ] ; then
        openssl aes-256-cbc -d -in "$object" | tar -xzC "${2:-.}" && cd "${2:-.}"
    else
        tar cz "$object" | openssl aes-256-cbc -e -out "${object}.tar.gz.enc" && rm -rf "$object"
    fi
}
