" Hard line breaks at 100 (e.g. `gq` formatting)
setlocal textwidth=100

"a: Automatic formatting of paragraphs. Every time text is inserted or
"   deleted the paragraph will be reformatted.  See |auto-format|.
"n: When formatting text, recognize numbered lists.  This actually uses
"   the 'formatlistpat' option, thus any kind of list can be used.
"w: Trailing white space indicates a paragraph continues in the next line.
"   A line that ends in a non-white character ends a paragraph.
setlocal formatoptions=wan

" The `w` above seems to be critical to ensuring that auto-formating doesn't
" explode when editing lists even with this pattern.
" http://stackoverflow.com/a/21610187/1999152
setlocal formatlistpat=^\s*\d\+\.\s\+\|^[-*+]\s\+

" Ensure single space after periouds, et al.
setlocal nojoinspaces

" Need me some spell check when writing
setlocal spell

