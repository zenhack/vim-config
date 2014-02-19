set nocp
set bs=2
set bg=dark

filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

" by default, tabstop tabs(8), max line length 78.
set ts=8 sw=8 noet

" tabstop 4 spaces
au FileType haskell,python set ts=4 sw=4 et

" tabstop 2 spaces
au FileType ats,hy,lua,clojure,ocaml,ruby,scheme,cabal set ts=2 sw=2 et

" My C conventions
" au FileType c,cpp set ts=4 sw=4 tw=80

au FileType html set ts=2 sw=2

" We want word wrapping for 'prose'. We also want spell check.
au FileType markdown,text set tw=72 spell

au BufRead,BufNewFile /tmp/alot.* set ft=mail
au FileType mail set spell

" Folds are useful, but I don't want to see them by default.
set nofen

let mapleader = "-"

set mouse=a

:inoremap jk <esc>

au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
au FileType python nnoremap M :!python -i %<cr><cr>

au FileType deutsch inoremap ae ä
au FileType deutsch inoremap oe ö
au FileType deutsch inoremap ue ü
au FileType deutsch inoremap sss ß