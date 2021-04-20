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
