#!/usr/bin/env bash

_docker_opts() {
    local cur prev jids dids
    while [ -n "$1" ] ; do
        case "$1" in
            --cur)  cur="$2" ; shift 2 ;;
            --prev) read -a prev <<< "$2" ; shift 2 ;;
            *)      return 0 ;;
        esac
    done

    case "$prev" in
        '') 
            {
                docker --help | awk '/^Commands:/,/$1/ { if ($1 ~ /^[a-z]*$/) print $1 }'
                awk '$0 ~ /^_dock_/ { split($0, cmd, "_") ; print cmd[3] }' $(which dock)
            } | sort | uniq
            ;;
        create|history|images|rmi|run|save|tag)
            prev=( ${prev[@]:1} )
            if [ -z "$cur" ] ; then
                {
                    sudo -En docker images --filter=dangling="false" --format='{{.Repository}}:{{.Tag}}' 2>/dev/null
                    printf -- $'%s\n' "${prev[@]}"
                } | sort | uniq -u
            else
                {
                    sudo -En docker images --filter=dangling="false" --format='{{.Repository}}:{{.Tag}}' 2>/dev/null | egrep "^$cur"
                    printf -- $'%s\n' "${prev[@]}"
                } | sort | uniq -u | cut -d ':' -f "$(sed 's/:/\n/g ' <<< "$cur" | wc -l)"-
            fi
            ;;
        attach|commit|cp|diff|exec|export|kill|logs|oom|pause|port|rename|restart|rm|start|stats|stop|top|unpause|update|wait)
            prev=( ${prev[@]:1} )
            jids=( $(sort ~/.bash_temporary/jobs 2>/dev/null | uniq) )
            if [ -z "${jids[*]}" ] ; then
                { 
                    sudo -E docker ps --all --format '{{.Names}}' 2>/dev/null
                    printf -- $'%s\n' "${prev[@]}"
                } | sort | uniq -u
            else
                dids=( $(sudo -En docker ps --all --format '{{.Names}}' 2>/dev/null) )
                if [ -z "${dids[*]}" ] ; then
                    { 
                        printf -- $'%s\n' "${jids[@]}"
                        printf -- $'%s\n' "${prev[@]}"
                    } | sort | uniq -u
                else
                    {
                        printf -- $'%s\n' "${jids[@]}" "${dids[@]}" | sort | uniq -d | awk '{print "_"$0}'
                        printf -- $'%s\n' "${dids[@]}"
                        printf -- $'%s\n' "${prev[@]}"
                    } | sort | uniq -u
                fi
            fi
            ;;
    esac
}

_docker_autocomplete() {
    local cmd cur prev
    read -a cmd <<< "$COMP_LINE"
    if [ "${COMP_LINE:${#COMP_LINE}-1}" == " " ] ; then
        cur=
        prev="${cmd[@]:1}"
    else
        cur="${cmd[@]:${#cmd[@]}-1}"
        prev="${cmd[@]:1:${#cmd[@]}-2}"
    fi
    compgen -X '-*' -W "$(_docker_opts --cur "$cur" --prev "$prev")" -- "${cur/*:}"
    return 0
}

complete -C _docker_autocomplete "$@" dock docker
