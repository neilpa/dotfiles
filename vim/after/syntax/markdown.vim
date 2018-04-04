" Exclude ALLCAPS words from spell check. Original idea from
" http://stackoverflow.com/questions/18196399/exclude-capitalized-words-from-vim-spell-check
"
" TODO This doesn't seem to work and just disables all spellcheck
"syn match excludeALLCAPSWords +\<[A-Z]\+\>+ contains=@NoSpell
