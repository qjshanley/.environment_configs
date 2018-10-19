#!/usr/bin/env bash

# environment files
ENV_FILES=~/code/qub3r/environment/files

if [ -d "$ENV_FILES" ]; then

	# make sure directories exist
	for dir in $(find "$ENV_FILES" -mindepth 1 -type d | sed -E "s@${ENV_FILES}/(.*)@\1@") ; do
		mkdir -p ~/"$dir"
	done

	# symlink files to the correct directories
	for target in $(find "$ENV_FILES" -mindepth 1 -type f -or -type l -not -name "*swp") ; do
		link_name=$(sed -E "s@${ENV_FILES}/(.*)@\1@" <<<"$target")
		rm -f ~/$link_name
		ln -s "$target" ~/"$link_name"
	done
fi
