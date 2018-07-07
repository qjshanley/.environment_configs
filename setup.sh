#!/usr/bin/env bash

# exit if error
set -e

# environment repo location
ENV_DIR=~/code/qub3r/environment

# ln files to the correct places
if [ -d ${ENV_DIR}/configs ]; then
	for object in $(ls -A ${ENV_DIR}/configs) ; do
		rm -rf ~/$object
		ln -s ${ENV_DIR}/configs/${object} ~/${object}
	done
fi
