# .bash_profile
# ----------------------------
# Read once by the login shell

# set environment variables
[ -d /usr/local/bin ] && [ -z "$(echo $PATH | grep /usr/local/bin)"  ] && export PATH=/usr/local/bin:$PATH
[ -d ~/.bin ] && [ -z "$(echo $PATH | grep ~/.bin)"  ] && export PATH=~/.bin:$PATH
[ -f /usr/local/bin/bash ] && export SHELL=/usr/local/bin/bash

# aliases and functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source autocompletion scripts
[ -d ~/.bin/autocompletion_scripts ] && for script in $(ls -A ~/.bin/autocompletion_scripts/*); do source $script; done
