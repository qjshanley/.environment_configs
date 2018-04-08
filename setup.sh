#!/usr/bin/env bash

# exit if error
set -e

# environment repo location
ENV_DIR=~/code/qub3r/environment

# ln files to the correct places
if [ -d "${ENV_DIR}/configs" ]; then

  # dot files
  for config in $(ls -A "${ENV_DIR}/configs/."); do
    ln -sf "${ENV_DIR}/configs/${config}" ~/.
  done

  # bash autocomplete
  ln -sf "${ENV_DIR}/.bash_autocomplete" ~/.
fi
