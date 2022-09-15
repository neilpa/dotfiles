#!/bin/sh
set -eu

#D="$(dirname "$(readlink -f "$0")")"

# TODO: Check for and use XDG_CONFIG_DIR
# Files directly symlinked to ~/.*
conf=${HOME}/.config
for d in ${conf}/_home ${conf}/_$(uname -s)
do
    [ -d "$d" ] || continue
    for f in ${d}/*
    do
        [ -f "$f" ] || continue
        ln -vis $f "${HOME}/.$(basename $f)"
    done
done
