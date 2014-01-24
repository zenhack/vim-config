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
au FileType haskell set ts=4 sw=4 et

" tabstop 2 spaces
au FileType hy,lua,clojure,ocaml,ruby,scheme,cabal set ts=2 sw=2 et

" My C conventions
au FileType c,cpp set ts=4 sw=4 tw=80

au FileType html set ts=2 sw=2

" We want word wrapping for 'prose'. We also want spell check.
au FileType markdown,text set wrap linebreak nolist tw=0 spell

" Folds are useful, but I don't want to see them by default.
set nofen

let mapleader = "-"

set mouse=a

" keyboard remapings
:inoremap jk <esc>
:inoremap <esc> <nop>

