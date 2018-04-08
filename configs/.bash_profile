# .bash_profile
# ----------------------------
# Read once by the login shell

# set environment variables
[ -d /usr/local/bin ] && [ -z "$(echo $PATH | grep /usr/local/bin)"  ] && export PATH=${PATH}:/usr/local/bin
[ -d /usr/local/go/bin ] && [ -z "$(echo $PATH | grep /usr/local/go/bin)" ] && export PATH=${PATH}:/usr/local/go/bin
[ -f /usr/local/bin/bash ] && export SHELL=/usr/local/bin/bash

# aliases and functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source autocompletion scripts
[ -d ~/.bash_autocomplete ] && for script in $(ls -A ~/.bash_autocomplete/*) ; do source $script ; done
