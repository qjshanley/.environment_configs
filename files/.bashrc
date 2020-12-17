# .bashrc
# -----------------------------------------
# Read everytime a new subshell is invoked.

# source files
for src in $(find -L "${HOME}/.bash_sources" -mindepth 1 -type f) ; do
  source $src
done

# vim style cmd line editing
set -o vi

# append to the history file, don't overwrite it
shopt -s histappend

# enable color support of ls and also add handy aliases
if [ -x "$(which dircolors)" ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
