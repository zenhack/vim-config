" {{{ init

let g:gofmt_command = "goimports"

filetype off
execute pathogen#infect()
filetype plugin indent on
syntax on
highlight BadWhitespace ctermbg=red guibg=red
set nu

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = []
let g:syntastic_haskell_checkers = []
let g:syntastic_ocaml_checkers = []
let g:syntastic_rst_checkers = []

let g:syntastic_cpp_compiler_options = '-std=c++17'

let g:pymode_rope = 0

call plug#begin('~/.vim/plugged')

Plug 'elmcast/elm-vim'
Plug 'reasonml-editor/vim-reason-plus'

call plug#end()

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
let et_fts += ['zig', 'json', 'typescript', 'javascript']

let noet_fts = ['html', 'xml', 'c']

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

let ts8_fts = ['c', 'go']

let ts2_fts = ['yaml', 'ats', 'html', 'hy', 'lua', 'clojure', 'scala']
let ts2_fts += ['ocaml', 'ruby', 'scheme', 'cabal', 'erlang', 'xml']
let ts2_fts += ['puppet', 'htmldjango', 'json', 'javascript', 'pony']
let ts2_fts += ['typescript', 'cpp', 'capnp']

let ts4_fts = ['idris', 'haskell', 'python', 'java', 'julia', 'rust']
let ts4_fts += ['elm', 'zig'] + prose_fts
" }}}
" }}}

set rtp^="/home/isd/.opam/system/share/ocp-indent/vim"

augroup vimrc " {{{
	autocmd!
	autocmd BufWritePre * :%s/\s\+$//e
	call Map_ftype(fen_fts, 'setlocal foldmethod=marker fen')
	call Map_ftype(et_fts, 'setlocal et')
	call Map_ftype(noet_fts, 'setlocal noet')

	call Map_ftype(ts2_fts, 'setlocal ts=2 sw=2')
	call Map_ftype(ts4_fts, 'setlocal ts=4 sw=4')
	call Map_ftype(ts8_fts, 'setlocal ts=8 sw=8')

	au FileType c set cscopetag

	au FileType yaml filetype plugin indent off
	" repls {{{
	au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
	au FileType python nnoremap M :!python -i %<cr><cr>
	au FileType scheme nnoremap M :!rlwrap guile -l %<cr><cr>
	" }}}
	" prose {{{
	" We want word wrapping for 'prose'. We also want spell check.
	au BufRead,BufNewFile /*.md setlocal ft=markdown
	call Map_ftype(prose_fts, 'setlocal tw=72 fo=aw2tq spell')
	au FileType help setlocal nospell
	" }}}
	" filetypes {{{
	au BufRead,BufNewFile *.pyi setlocal ft=python
	au BufRead,BufNewFile *.hamlet setlocal ft=haskell
	au BufRead,BufNewFile *.bkp setlocal ft=haskell
	au BufRead,BufNewFile *.hsig setlocal ft=haskell
	au BufRead,BufNewFile /tmp/alot.* setlocal ft=mail
	au BufRead,BufNewFile *.mail setlocal ft=mail
	au BufRead,BufNewFile *.pl setlocal ft=prolog
	au BufRead,BufNewFile *.h setlocal ft=c
	au BufRead,BufNewFile jbuild setlocal ft=scheme
	au BufRead,BufNewFile dune setlocal ft=scheme
	" }}}
	au FileType python match BadWhitespace /\s\+$/

	" The usual 80ish characters tends to be too short for go programs.
	au FileType go setlocal tw=100
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
