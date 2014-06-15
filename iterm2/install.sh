#!/bin/sh

brew cask install iterm2-beta

defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder true
defaults write com.googlecode.iterm2 PrefsCustomFolder $ZSH/iterm2
