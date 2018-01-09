" {{{ init

let g:gofmt_command = "goimports"

filetype off
execute pathogen#infect()
filetype plugin indent on
syntax on
highlight BadWhitespace ctermbg=red guibg=red
set nu

let g:pymode_rope = 0


if has("cscope")
	set cst
endif

set nocp
set bs=2

if $BG_COLOR == "light"
	set bg=light
else
	set bg=dark
endif

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
let et_fts = ['haskell',  'java',  'yaml', 'ats', 'hy', 'lua', 'scala']
let et_fts += ['clojure', 'ocaml', 'ruby', 'scheme', 'cabal']
let et_fts += ['erlang', 'markdown', 'text', 'mail', 'gitcommit']
let et_fts += ['puppet', 'julia', 'elm', 'rust', 'idris', 'pony']

let noet_fts = ['html', 'xml']

" }}}
" {{{ foldenable

set nofen
set foldmethod=indent

" Fix vim's braindead autocomplete defaults:
set wildmode=list:longest

set wildignorecase

let fen_fts = ['vim']

" }}}
" tabstop {{{

" by default, tabstop tabs(8), max line length 80.
set ts=8 sw=8 noet tw=80

let ts2_fts = ['yaml', 'ats', 'html', 'hy', 'lua', 'clojure', 'scala']
let ts2_fts += ['ocaml', 'ruby', 'scheme', 'cabal', 'erlang', 'xml']
let ts2_fts += ['puppet', 'htmldjango', 'json', 'javascript', 'elm', 'pony']

let ts4_fts = ['idris', 'haskell', 'python', 'java', 'julia', 'rust'] + prose_fts
" }}}
" }}}
augroup vimrc " {{{
	autocmd!
	autocmd BufWritePre * :%s/\s\+$//e
	call Map_ftype(fen_fts, 'setlocal foldmethod=marker fen')
	call Map_ftype(et_fts, 'setlocal et')
	call Map_ftype(noet_fts, 'setlocal noet')

	call Map_ftype(ts2_fts, 'setlocal ts=2 sw=2')
	call Map_ftype(ts4_fts, 'setlocal ts=4 sw=4')

	au FileType c set cscopetag

	au FileType yaml filetype plugin indent off
	" repls {{{
	au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
	au FileType python nnoremap M :!python -i %<cr><cr>
	au FileType scheme nnoremap M :!rlwrap guile -l %<cr><cr>
	" }}}
	" prose {{{
	" We want word wrapping for 'prose'. We also want spell check.
	au BufRead,BufNewFile /*.md set ft=markdown
	call Map_ftype(prose_fts, 'set tw=72 fo=aw2tq spell')
	au FileType help set nospell
	" }}}
	" filetypes {{{
	au BufRead,BufNewFile *.pyi set ft=python
	au BufRead,BufNewFile *.hamlet set ft=haskell
	au BufRead,BufNewFile *.bkp set ft=haskell
	au BufRead,BufNewFile *.hsig set ft=haskell
	au BufRead,BufNewFile /tmp/alot.* set ft=mail
	au BufRead,BufNewFile *.mail set ft=mail
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

nnoremap <leader>d /PGP<cr>VG:s/[> ]*//<cr>gg/PGP<cr>VG:!gpg -d<cr>gg/Quoting<cr>jVG:s/^/> /<cr>:%s/\r//g<cr>
nnoremap <leader>f gwip<cr>
" }}}
