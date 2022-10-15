#!/bin/sh
set -eu

#D="$(dirname "$(readlink -f "$0")")"

# TODO: Check for and use XDG_CONFIG_DIR
# Files directly symlinked to ~/.*
cfg=${HOME}/.config
for d in ${cfg}/_home ${cfg}/_$(uname -s)
do
    [ -d "$d" ] || continue
    for f in ${d}/*
    do
        [ -f "$f" ] || [ -d "$f" ] || continue
        ln -vis $f "${HOME}/.$(basename $f)"
    done
done

# Missing directories break some history, cache, etc. files
source ${cfg}/_home/xdgenv
for prog in bash node npm python vim zsh; do
    mkdir -pv ${XDG_DATA_HOME}/${prog}
    mkdir -pv ${XDG_CACHE_HOME}/${prog}
done

# Special overrides for vscode settings
# https://stackoverflow.com/a/53841945/1999152
case $(uname -s) in
  Darwin)
    vscode_user="${HOME}/Library/Application Support/Code/User"
    ln -vis ${cfg}/_home/vscode/settings.json "${vscode_user}/settings.json"
    ln -vis ${cfg}/_home/vscode/keybindings.json "${vscode_user}/keybindings.json"
    ;;
esac
