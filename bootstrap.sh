#!/usr/bin/env sh
#
# Bootstrap the setup a new system on OS X.

# Where is bootstrap
DIR=$( cd "$( dirname "$0" )" && pwd )

if [ ! $(command -v brew) ];
then
  echo 'Installing Homebrew'
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
#  brew doctor
else
  echo 'Homebrew already installed'
fi

# TODO Setup zsh as default shell


# Here down is effectively just update and should be runnable all the time

# Install/Update everything in our Brewfile
brew bundle $DIR/Brewfile

# Sync all the dotfile repositories
mr -t -c $DIR/mrconfig.symlink checkout

# Symlink files into the $HOME that need it
$DIR/symlink.sh

