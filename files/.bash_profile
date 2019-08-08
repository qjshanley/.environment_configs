# .bash_profile
# ----------------------------
# Read once by the login shell

# run .bashrc
test -f ~/.bashrc && source ~/.bashrc

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
    test -r "$config" && mv "$config" "${config}.disable"
done

# Bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.bin/google-cloud-sdk/path.bash.inc" ]; then . "${HOME}/.bin/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/.bin/google-cloud-sdk/completion.bash.inc" ]; then . "${HOME}/.bin/google-cloud-sdk/completion.bash.inc"; fi
