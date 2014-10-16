export EDITOR='vim'

# Ensure XDG directories are defined
[[ -n $XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ -n $XDG_CACHE_HOME ]] || export XDG_CACHE_HOME="$HOME/.cache"

