
fpath=( $ZDOTDIR/functions $fpath )

# Aliases
alias zrc="vim $ZDOTDIR/.zshrc"
alias vrc="vim ~/.vim/vimrc"

alias   ..='cd ..'          # Go up one directory
alias  ...='cd ../..'       # Go up two directories
alias ....='cd ../../..'    # And for good measure

alias l='ls -lh'           # Long view, show hidden
alias la='ls -AF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden

autoload -U promptinit && promptinit
prompt pure

