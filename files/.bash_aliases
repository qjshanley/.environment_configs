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

function pinger { while true ; do date ; ping -c1 $1 ; sleep 300 ; echo ; done ; }

function shrink { sed -En '/[^\^$]/p' "$@" ; }

function _is_mac { [ "$(uname -s)" == "Darwin" ] && return 0 || return 1 ; }

function LIST { netstat -an | sed -n '1,2p ; /^tcp.*LISTEN/p' ; }

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

function compare {
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
        fi
    else
        diff -s $1 $2
    fi
    return 0
}

function pod-api {
    sudo -E docker exec -it -u postgres postgresql bash -c '
        PG_CURR_DB=pod-api
        env PSQL_EDITOR=$(which vim) psql $PG_CURR_DB
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

function dex {
    POD="$1" ; shift 1
    case "$POD" in
        pod02)
            export DATICA_EMAIL=quin@datica.com
            export ACCOUNTS_HOST=https://product.datica.com
            export AUTH_HOST=https://auth.datica.com
            export PAAS_HOST=https://paas-api.catalyze.io
            export DATICA_LOG_LEVEL=info
            export POD_ID=pod02
            export PODID=pod02
            rm ~/.datica
            datica whoami
            ;;
        pod05)
            export DATICA_EMAIL=quin@datica.com
            export ACCOUNTS_HOST=https://product.de.datica.com
            export AUTH_HOST=https://auth.de.datica.com
            export PAAS_HOST=https://paas-api.de.datica.com
            export DATICA_LOG_LEVEL=info
            export POD_ID=pod05
            export PODID=pod05
            rm ~/.datica
            datica whoami
            ;;
        sbox05)
            export DATICA_EMAIL=quin@datica.com
            export ACCOUNTS_HOST=https://product-sandbox.catalyzeapps.com/stratum
            export AUTH_HOST=https://auth-sandbox.catalyzeapps.com
            export PAAS_HOST=https://sandbox-darwin.catalyzeapps.com
            export DATICA_LOG_LEVEL=info
            export POD_ID=sbox05
            export PODID=sbox05
            rm ~/.datica
            datica whoami
            ;;
        *)
            echo The pod \"$POD\" is not valid. Please use: pod02 pod05 sbox05
            ;;
    esac
}
