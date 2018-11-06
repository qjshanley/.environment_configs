# .bash_profile
# ----------------------------
# Read once by the login shell

# run .bashrc
test -f ~/.bashrc && source ~/.bashrc

DISABLE_CONFIGS=( ~/.bash_login ~/.profile )
for config in "${DISABLE_CONFIGS[@]}" ; do
    test -r "$config" && mv "$config" "${config}.disable"
done

