# .bashrc
# -----------------------------------------
# Read everytime a new subshell is invoked.

# Set PATH Variable
BINS=(
    ~/.bin
    ~/.bash_scripts
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
    'HISTTIMEFORMAT="%F %T "'
    'DATICA_ENV="d9a425c1-1a68-42ee-9261-0f675e87d70a"'
    'EDITOR="vim"'
    'VISUAL="vim"'
    'TERM="xterm-256color"'
    'GOROOT="/usr/local/go"'
    'GOPATH="~/code/go"'
    "PSQL_EDITOR=\"$(which vim)\""
)
for evar in "${EVARS[@]}" ; do eval " export $evar" ; done

# Set Shell Variables
test -x /usr/local/bin/bash && export SHELL=/usr/local/bin/bash
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# source files
SOURCES=( ~/.bash_aliases ~/.bash_sources )
for src in "${SOURCES[@]}" ; do
    # source single files
    test -f "$src" && source "$src"
    # source full directories
    if test -d "$src" && test ! -z "$(ls -A "$src")" ; then
        for file in "$src"/* ; do source "$file" ; done
    fi
done

# kubectl completion
[ $(which kubectl) ] && source <(kubectl completion bash)

# vim style cmd line editing
set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=1000000

# set a fancy prompt (non-color, unless we know we "want" color)
function parse_git_branch {
    git branch 2> /dev/null | sed -n '/^*/s/^* \(.*\)/[\1]/p'
}
function parse_git_branch_color {
    #local git_status="$(git status 2> /dev/null | sed -n '/^On branch/p ; /^Changes not staged for commit:/p ; /^Changes to be committed:/p ; /^Untracked files:/p')"
    local git_status="$(git status 2> /dev/null | sed -n '/^[A-Z]/p')"
    if [ -n "$git_status" ] ; then
        local git_branch="$(sed -n '/^On branch /s/^On branch \(.*\)/[\1]/p' <<< "$git_status")"
        local no_color='\e[0;00m'
        if [ -n "$(IFS=$'\n' ; compgen -W "$git_status" "Untracked files:")" ] ; then
            # red
            local color='\e[1;31m'
        elif [ -n "$(IFS=$'\n' ; compgen -W "$git_status" "Changes not staged for commit:")" ] ; then
            # red
            local color='\e[1;31m'
        elif [ -n "$(IFS=$'\n' ; compgen -W "$git_status" "Changes to be committed:")" ] ; then
            # yellow
            local color='\e[1;33m'
        else
            # green
            local color='\e[1;32m'
        fi
        printf -- "${color}${git_branch}${no_color}"
    fi
}
function escaped_working_dir {
    printf -- '%q' "$(pwd)"
}
ps=()
[ -n "$debian_chroot" ] && ps=( '${debian_chroot:+($debian_chroot)}' )
case "$TERM" in
    xterm-color|*-256color) 
        ps+=( '\e[0;32m\u@\h\e[0;00m' )
        ps+=( '\e[1;34m$(escaped_working_dir)\e[0;00m' )
        ps+=( '$(parse_git_branch_color)' )
        ;;
    *)
        ps+=( '\u@\h' )
        ps+=( '$(escaped_working_dir)' )
        ps+=( '$(parse_git_branch)' )
        ;;
esac
export PS1="${ps[@]}\n\$ "
unset ps

# enable color support of ls and also add handy aliases
if [ -x "$(which dircolors)" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
