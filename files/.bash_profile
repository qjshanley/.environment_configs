# .bash_profile
# ----------------------------
# Read once by the login shell

# run .bashrc
test -f ~/.bashrc && source ~/.bashrc

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
    test -r "$config" && mv "$config" "${config}.disable"
done


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/qub3r/.bin/google-cloud-sdk/path.bash.inc' ]; then . '/Users/qub3r/.bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/qub3r/.bin/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/qub3r/.bin/google-cloud-sdk/completion.bash.inc'; fi
