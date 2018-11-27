#!/bin/sh
set -eu

cd "${HOME}/.config/tilde"
for f in *
do
    ln -i "$f" "${HOME}/.$f"
done
