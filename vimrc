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
au FileType clojure,ocaml,lua,ruby,scheme set ts=2 sw=2 et

" for http://bitbucket.org/ids/zero
au FileType c set ts=4 sw=4 tw=78

" In general, we want 72 columns for 'prose'. We also want spell check.
au FileType markdown set tw=72 spell

let mapleader = "-"
