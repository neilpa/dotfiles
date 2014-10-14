#!/bin/sh
#
# Python
#
# Installs pip and other python packages

# TODO figure out the "right way" to install w/out sudo

if test ! $(which pip)
then
  echo "  Installing Python's package manager"
  sudo easy_install pip > /tmp/pip-install.log
fi

if test ! $(which pygmentize)
then
  echo "  Installing Python's package manager"
  sudo pip install Pygments > /tmp/pygments-install.log
fi

exit 0
