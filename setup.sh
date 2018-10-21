#!/usr/bin/env bash
IFS=$'\t\n'

# environment files
ENV_FILES="${1:?Please provide the base dir of the repo}"/files

if [ -d "$ENV_FILES" ]; then

	# make sure directories exist
        ( cd "$ENV_FILES" ; find . -type d -mindepth 1 -print0 | tar czh --null --files-from /dev/stdin ) | ( cd ; tar xz )

	# symlink files to the correct directories
	for target in $(cd "$ENV_FILES" ; find . -mindepth 1 -type f -or -type l -and -not -name "*swp") ; do
		#link_name=$(sed -E "s@${ENV_FILES}/(.*)@\1@" <<<"$target")
		ln -fsrL "$ENV_FILES"/"$target" ~/"$target"
	done
fi
