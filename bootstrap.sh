#!/bin/sh
set -eu

cd "${HOME}/.config/turds"
for f in *
do
    # Test for existing hardlinks
    if [ "$f" -ef "${HOME}/.$f" ]
    then
	    echo "$f": already hardlinked
    else
        ln -vi "$f" "${HOME}/.$f"
    fi
done
