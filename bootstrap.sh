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
        [ -f "$f" ] || continue
        ln -vis $f "${HOME}/.$(basename $f)"
    done
done

# Missing directories break some history, cache, etc. files
source ${cfg}/_home/xdgenv

mkdir -p ${XDG_DATA_HOME}/vim
mkdir -p ${XDG_DATA_HOME}/zsh

mkdir -p ${XDG_CACHE_HOME}/vim
mkdir -p ${XDG_CACHE_HOME}/zsh

