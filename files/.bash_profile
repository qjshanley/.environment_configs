# .bash_profile
# ----------------------------
# Read once by the login shell

# Get list of gnubin directories
GNUBINS="$(find /usr/local/opt -type d -follow -name gnubin -print)";
for bindir in ${GNUBINS[@]}; do
  export PATH=$bindir:$PATH;
done;

# Set PATH Variable
BINS=(
  "${HOME}/.bin"
  "${HOME}/.bash_scripts"
  "/usr/local/go/bin"
  "${HOME}/code/go/bin"
  "${HOME}/Library/Python/2.7/bin"
)
for bin in "${BINS[@]}" ; do
  test -d "$bin" && PATH+=":${bin}"
done
export "PATH=$PATH"

# Set Environment Variables
EVARS=(
  'HISTTIMEFORMAT="%F %T "'
  'HISTCONTROL=ignoreboth'
  'HISTSIZE=10000'
  'HISTFILESIZE=1000000'
  'DATICA_ENV="d9a425c1-1a68-42ee-9261-0f675e87d70a"'
  'EDITOR="vim"'
  'VISUAL="vim"'
  'TERM="xterm-256color"'
  'GOROOT="/usr/local/go"'
  "GOPATH=\"${HOME}/code/go\""
  "PSQL_EDITOR=\"$(which vim)\""
)
for evar in "${EVARS[@]}" ; do eval " export $evar" ; done

# Set Shell Variables
test -x /usr/local/bin/bash && export SHELL=/usr/local/bin/bash
# make less more friendly for non-text input files, see lesspipe(1)
test -x /usr/bin/lesspipe && eval "$(lesspipe)"

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
  test -r "$config" && mv "$config" "${config}.disable"
done

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# run .bashrc
test -f ~/.bashrc && source ~/.bashrc

# Start screen session if connecting to a remote
test -n "$SSH_TTY" -a -z "$STY" && exec screen -U -DR -S ssh -t host -p 0

