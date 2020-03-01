#!/bin/sh
set -eu

D="$(dirname "$(readlink -f "$0")")"

# Directories symlinked into ~
ln -vis "${D}/bin" "${HOME}/"

# Directories symlinked into ~/.config
mkdir -p "${HOME}/.config"
ln -vis "${D}/git" "${HOME}/.config/"
ln -vis "${D}/vim" "${HOME}/.config/"
ln -vis "${D}/zsh" "${HOME}/.config/"

# Files directly hardlinked to ~/.*
cd "${D}/turds"
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
