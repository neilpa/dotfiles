#!/bin/sh
set -eu

D="$(dirname "$(readlink -f "$0")")"

# Directories symlinked into ~
ln -vis "${D}/bin" "${HOME}/"

# Directories symlinked into ~/.config
mkdir -p "${HOME}/.config"
ln -vis "${D}/git" "${HOME}/.config/"
ln -vis "${D}/vim" "${HOME}/.config/"
ln -vis "${D}/z"   "${HOME}/.config/"
ln -vis "${D}/zsh" "${HOME}/.config/"

# Files directly symlinked to ~/.*
cd "${D}/turds"
for f in *
do
    ln -vis "${D}/$f" "${HOME}/.$f"
done
