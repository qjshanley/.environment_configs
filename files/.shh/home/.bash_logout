# ~/.bash_logout
# -------------------------------------------
# executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ] ; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# remove ~/.bash_temporary
rm -rf ~/.bash_temporary

# Cleanup
rm -rf ~/.bash_scripts
rm -rf ~/.bash_sources
rm -f ~/.bin/salty
