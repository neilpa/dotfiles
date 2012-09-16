#!/usr/bin/env zsh

echo Creating main Prezto link
unlink $HOME/.zprezto
ln -v -s $HOME/code/dotfiles/zsh/prezto $HOME/.zprezto

# Install Prezto
# https://github.com/sorin-ionescu/prezto#installation
echo Creating Prezto to zsh links
setopt EXTENDED_GLOB
for rcfile in ~/.zprezto/runcoms/^README.md(.N); do
    ln -v -s -f "$rcfile" "$HOME/.${rcfile:t}"
done

echo Updating user shell to zsh
sudo chsh -s /bin/zsh $USER

# https://github.com/sorin-ionescu/prezto#mac-os-x
echo Disabling path_helper
sudo chmod ugo-x /usr/libexec/path_helper

