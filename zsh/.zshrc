
# My functions
fpath=( $ZDOTDIR/functions $fpath )

# Aliases
alias zrc="vim $ZDOTDIR/.zshrc"
alias vrc="vim ~/.vim/vimrc"
alias grc="vim ~/.config/git/config"

alias   ..='cd ..'          # Go up one directory
alias  ...='cd ../..'       # Go up two directories
alias ....='cd ../../..'    # And for good measure

alias l='ls -A'     # Short view, show hidden
alias ll='ls -l'    # Long view, no hidden
alias la='ls -lA'   # Long view, show hidden

# Completion
autoload -Uz compinit; compinit
# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Nice prompt - https://github.com/sindresorhus/pure
autoload -U promptinit && promptinit
prompt pure

