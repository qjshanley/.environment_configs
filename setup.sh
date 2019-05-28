#!/usr/bin/env bash

BASE="$(dirname "$0")"
ENV_FILES="${BASE}/files"

if [ -d "$ENV_FILES" ]; then
    # make sure directories exist
    ( cd "$ENV_FILES" ; find . -mindepth 1 -type d -print0 | tar czh --null --files-from /dev/stdin ) | ( cd ; tar xz )

    # symlink files to the correct directories
    for target in $(cd "$ENV_FILES" ; find . -mindepth 1 -type f -or -type l -and -not -name "*swp") ; do
        ln -fsrL "$ENV_FILES"/"$target" ~/"$target"
    done
else
    echo "Could not find environment files"
fi
