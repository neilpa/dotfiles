
alias zrc="vim ~/.config/zsh/.zshrc"

fpath=( $ZDOTDIR/functions $fpath )

autoload -U promptinit && promptinit
prompt pure

