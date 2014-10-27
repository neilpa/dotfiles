#### zsh-isms

Collection of zsh snippets

    # Print a zsh array, each entry on a single line
    > print -l $fpath

    # Unique-ify an array with the `u' parameter expansion flag
    # http://zsh.sourceforge.net/Doc/Release/Expansion.html#index-parameter-expansion-flags
    > print -l ${(u)userdirs}
