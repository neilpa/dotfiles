"TODO Not sure how much of this still works

"Stuff specific to the CoreXT build environment
"if !exists("$INETROOT")
"    finish
"endif

"==========================================================================
" Environement
"==========================================================================

"Find files in the source tree quickly. Limit scope to my
"common dirs at the beginning w/ broader scope at the end
set path+=$_NTDEVELOPER/**1

"Branch-specific tags files
set tags+=$INETROOT/tags
let g:FileList_IndexFile = expand("$INETROOT/filetags")
"let g:FileList_EditCmd = "silent edit +stopinsert"

"==========================================================================
" Search
"==========================================================================

" TODO http://wincode

"==========================================================================
" Building
"==========================================================================

" When 'shellpipe' is set to an empty string, no redirection of the
" ":make" output will be done.  This is useful if you use a 'makeprg'
" that writes to 'makeef' by itself.  If you want no piping, but do
" want to include the 'makeef', set 'shellpipe' to a single space.
" Don't forget to precede the space with a backslash: ":set sp=\ ".
" In the future pipes may be used for filtering and this option will
" become obsolete (at least for Unix).
" This option cannot be set from a |modeline| or in the |sandbox|, for
" security reasons.

"Build.cmd - errors for nmake, rcxml, and dui
set makeprg=build
set errorformat=%*\\d>%f(%l)\ :\ error\ %t%n:\ %m
set errorformat+=%*\\d>%f(%l)\ :\ warning\ %t%n:\ %m
set errorformat+=%f(%l)\ :\ error\ %t%n:\ %m
set errorformat+=%*\\d>%f(%l)\ :\ error%m

"TODO: Different types of builds
"Build current
"Build current and link
"Build changes
"Build changes and link
"Build resources
"Build all
"Build all clean

map <Leader>bb  <ESC>:call <SID>BuildAsync('')<CR>
map <Leader>bcz <ESC>:call <SID>BuildAsync('-cZ')<CR>

function! <SID>BuildAsync(args)
    let l:path = fnamemodify('%', ':p:h')
    echomsg "Building " . l:path
    exec '!start /min buildwrap.cmd ' . l:path  . ' ' . v:servername . ' '. a:args
endfunction

function! BuildDone()
    cclose
    echomsg "Build succeeded"
endfunction

function! BuildFailed(errors)
    botright copen
    exec 'cgetfile ' . a:errors
endfunction

"==========================================================================
" Source Depot
"==========================================================================

"Automagically checkout files when starting to edit
let s:IgnoreChange=0
autocmd! FileChangedRO $INETROOT/* nested
    \ let s:IgnoreChange=1 |
    \ call system("sd.exe edit " . expand("%")) |
    \ set noreadonly
autocmd! FileChangedShell $INETROOT/*
    \ if 1 == s:IgnoreChange |
    \   let v:fcs_choice="" |
    \   let s:IgnoreChange=0 |
    \ else |
    \   let v:fcs_choice="ask" |
    \ endif

"Windiff changes
"TODO read the $DIFF variable
nmap <Leader>wd :silent !start odd -lo<CR>

"SDV opened file
nmap <Leader>sdv :silent !start sdv %<CR>

