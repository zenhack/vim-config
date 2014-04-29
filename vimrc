set nocp
set bs=2
set bg=dark

filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

" Folds are useful, but I don't want to see them by default.
set nofen

let mapleader = "-"
let maplocalleader = "\\"

:nnoremap <leader>ev :tabe $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

set mouse=a

:inoremap jk <esc>

" by default, tabstop tabs(8), max line length 80.
set ts=8 sw=8 noet tw=80

augroup vimrc
	autocmd!
	" tabstop 4 spaces
	au FileType haskell,python,java,xml set ts=4 sw=4 et

	" tabstop 2 spaces
	au FileType ats,hy,lua,clojure,ocaml,ruby,scheme,cabal set ts=2 sw=2 et

	" My C conventions
	" au FileType c,cpp set ts=4 sw=4 tw=80

	au FileType html set ts=2 sw=2

	" We want word wrapping for 'prose'. We also want spell check.
	au BufRead,BufNewFile /*.md set ft=markdown
	au FileType markdown,text set tw=72 spell

	au BufRead,BufNewFile /tmp/alot.* set ft=mail
	au FileType mail set spell

	au FileType help set nospell


	au BufRead,BufNewFile *.hamlet set ft=haskell


	au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
	au FileType python nnoremap M :!python -i %<cr><cr>
	au FileType scheme nnoremap M :!rlwrap csi %<cr><cr>

	au BufRead,BufNewFile *.de set ft=deutsch
	au FileType deutsch inoremap ae ä
	au FileType deutsch inoremap oe ö
	au FileType deutsch inoremap ue ü
	au FileType deutsch inoremap Ae Ä
	au FileType deutsch inoremap Oe Ö
	au FileType deutsch inoremap Ue Ü
	au FileType deutsch inoremap sss ß
augroup END

nnoremap J <c-w>j
nnoremap K <c-w>k
nnoremap L <c-w>l
nnoremap H <c-w>h

