#!/bin/sh
set -eu

#D="$(dirname "$(readlink -f "$0")")"

# TODO: Check for and use XDG_CONFIG_DIR
# Files directly symlinked to ~/.*
cd "${HOME}/.config/turds"
for f in *
do
    ln -v "${HOME}/.config/turds/$f" "${HOME}/.$f"
done
