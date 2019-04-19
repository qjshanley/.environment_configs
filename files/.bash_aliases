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

function _is_mac { [ "$(uname -s)" == "Darwin" ] && return 0 || return 1 ; }

function LIST { netstat -an | sed -n '1,2p ; /^tcp.*LISTEN/p' ; }

function dat { bash ~/code/datica/toolbox/misc/exec_for_each_service_in_env.sh $@ ; }

function dex { export DATICA_ENV=$1 ; }

function pinger {
    while true ; do date ; ping -c1 $1 ; sleep 300 ; echo ; done
}

function subenv {
	eval "cat <<- EOF
	    $(<$1)
	EOF
	"
}

function aws-configure {
    read -p  "AWS Access Key ID [None]: "        aws_access_key_id
    read -sp "AWS Secret Access Key [None]: "    aws_secret_access_key ; echo
    read -p  "Default region name [us-east-1]: " aws_default_region
    read -p  "Default output format [text]:"     aws_default_output
    export AWS_ACCESS_KEY_ID=${aws_access_key_id}
    export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
    export AWS_DEFAULT_REGION=${aws_default_region:-us-east-1}
    export AWS_DEFAULT_OUTPUT=${aws_default_output:-text}
}

function diss {
    [ ! -f "$1" ] && { echo File required for ARG 1 ; return 1 ; }
    [ ! -f "$2" ] && { echo File required for ARG 2 ; return 1 ; }
    if [ "$(diff $1 $2)" ] ; then
        local F1_WIDTH="$(( 10 + ( 2 * $(cut -d ' ' -f1 <(wc -L "$1")) ) ))"
        local F2_WIDTH="$(( 10 + ( 2 * $(cut -d ' ' -f1 <(wc -L "$2")) ) ))"
        [ "$F1_WIDTH" -gt "$F2_WIDTH" ] && local WIDTH=$F1_WIDTH || local WIDTH=$F2_WIDTH
        if [ $(( $(tput cols) - $WIDTH )) -lt 0 ] ; then
            diff -W "$(tput cols)" -y "$1" "$2"
        else
            diff -W "$WIDTH" -y "$1" "$2"
        fi | less
    fi
    return 0
}

function pod-api {
    sudo -E docker exec -it -u postgres postgresql bash -c '
        PSQL_EDITOR=$(which vim)
        PG_CURR_DB=pod-api
        psql $PG_CURR_DB
    '
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

function tunnel {
    ALIAS="${1?You must provide an alias to tunnel to: web core pod05}" ; shift 1
    case "$ALIAS" in
        web)
            LOCAL_HOST=localhost
            LOCAL_PORT=8090
            REMOTE_HOST=172.26.28.82
            REMOTE_PORT=8080
            ;;
        core)
            LOCAL_HOST=localhost
            LOCAL_PORT=8090
            REMOTE_HOST=172.27.24.113
            REMOTE_PORT=8080
            ;;
        pod05)
            LOCAL_HOST=localhost
            LOCAL_PORT=8090
            REMOTE_HOST=sensu.pod05.catalyzeapps.com
            REMOTE_PORT=8080
            ;;
        *)     echo "ERROR: Alias unknown. Needs to match one of: web core pod05" ;;
    esac
    echo "http://${LOCAL_HOST}:${LOCAL_PORT} --> ${REMOTE_HOST}:${REMOTE_PORT}"
    ssh "$@" -N -L "$LOCAL_PORT":"$LOCAL_HOST":"$REMOTE_PORT" $REMOTE_HOST
}
