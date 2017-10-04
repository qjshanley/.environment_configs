environment_configs
===================

Configs for vim, ssh, screen, etc.

### Add this to /etc/bash.bashrc to allow all users to keep a full history ###
```
HISTDIR="${HOME}/.bash_history"
mkdir -p $HISTDIR
HISTTIMEFORMAT='%F %T '
HISTFILE="${HISTDIR}/history-$(date +%Y%m%d)"
HISTFILESIZE=-1
HISTSIZE=-1
HISTCONTROL=ignoredups
HISTIGNORE=?:??
# append to history, don't overwrite it
shopt -s histappend
# attempt to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
shopt -s lithist
```
