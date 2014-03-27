# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Build an install
install git
#install mr
install macvim --override-system-vim --with-lua --with-luajit

# cmake for building (vim's YouCompleteMe)
install cmake

# code search
install ag

# Setup Homebrew Casks for apps
tap phinze/cask
install brew-cask

# Install apps
cask install alfred
# cask install google-chrome
cask install vagrant
cask install spectacle

# Development
cask install intellij-idea-community

# Install fonts
tap caskroom/fonts

# Make sure alfred finds all cask installed apps
cask alfred link

# Remove outdated versions from the cellar
cleanup

