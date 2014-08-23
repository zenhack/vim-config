" {{{ init
filetype off
execute pathogen#infect()
filetype plugin indent on
syntax on
highlight BadWhitespace ctermbg=red guibg=red

let g:pymode_rope = 0

if has("cscope")
	set cst
endif

set nocp
set bs=2
set bg=dark
set mouse=a
set incsearch
" }}}
" {{{ functions
fu Map_ftype(ftypes, cmd)
	for ftype in a:ftypes
		execute 'au Filetype' ftype a:cmd
	endfor
endf
" }}}
" {{{ classify filetypes
let prose_fts = ['gitcommit', 'mail',  'markdown',  'text']
" {{{ tabexpand
let et_fts = ['haskell',  'java',  'yaml', 'ats', 'hy', 'lua']
let et_fts += ['clojure', 'ocaml', 'ruby', 'scheme', 'cabal']
let et_fts += ['erlang', 'markdown', 'text', 'mail', 'gitcommit']
let et_fts += ['puppet']

let noet_fts = ['html', 'xml']

" }}}
" {{{ foldenable

set nofen
set foldmethod=indent

let fen_fts = ['vim']

" }}}
" tabstop {{{

" by default, tabstop tabs(8), max line length 80.
set ts=8 sw=8 noet tw=80

let ts2_fts = ['yaml', 'ats', 'html', 'hy', 'lua', 'clojure']
let ts2_fts += ['ocaml', 'ruby', 'scheme', 'cabal', 'erlang', 'xml']
let ts2_fts += ['puppet']

let ts4_fts = ['haskell', 'python', 'java', 'markdown'] + prose_fts
" }}}
" }}}
augroup vimrc " {{{
	autocmd!
	call Map_ftype(fen_fts, 'setlocal foldmethod=marker fen')
	call Map_ftype(et_fts, 'setlocal et')
	call Map_ftype(noet_fts, 'setlocal noet')

	call Map_ftype(ts2_fts, 'setlocal ts=2 sw=2')
	call Map_ftype(ts4_fts, 'setlocal ts=4 sw=4')

	au FileType yaml filetype plugin indent off
	" repls {{{
	au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
	au FileType python nnoremap M :!python2 -i %<cr><cr>
	au FileType scheme nnoremap M :!rlwrap csi %<cr><cr>
	" }}}
	" prose {{{
	" We want word wrapping for 'prose'. We also want spell check.
	au BufRead,BufNewFile /*.md set ft=markdown
	call Map_ftype(prose_fts, 'set tw=72 spell')
	au FileType help set nospell
	" }}}
	" filetypes {{{
	au BufRead,BufNewFile *.hamlet set ft=haskell
	au BufRead,BufNewFile *.elm set ft=haskell
	au BufRead,BufNewFile /tmp/alot.* set ft=mail
	au BufRead,BufNewFile *.pl set ft=prolog
	" }}}
	au FileType python match BadWhitespace /\s\+$/

	" The usual 80ish characters tends to be too short for go programs.
	au FileType go set tw=100

augroup END " }}}
" {{{ key bindings
let mapleader = "-"
let maplocalleader = "\\"

inoremap jk <esc>

nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap J <c-w>j
nnoremap K <c-w>k
nnoremap L <c-w>l
nnoremap H <c-w>h

nnoremap <c-w> <nop>
" }}}
