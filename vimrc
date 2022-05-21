" {{{ init


filetype off
execute pathogen#infect()
filetype plugin indent on
syntax on
highlight BadWhitespace ctermbg=red guibg=red
set nu

set autoread

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_python_checkers = []
" let g:syntastic_haskell_checkers = []
" let g:syntastic_ocaml_checkers = []
" let g:syntastic_rst_checkers = []
"
" let g:syntastic_c_config = '.syntastic_c_config'
"
" let g:syntastic_cpp_compiler_options = '-std=c++17'

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
let et_fts += ['zig', 'json', 'unison', 'capnp', 'cpp', 'javascript', 'typescript']
let et_fts += ['html',]

let noet_fts = ['xml', 'c']

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

let ts2_fts = ['yaml', 'ats', 'html', 'hy', 'lua', 'clojure', 'scala', 'typescript']
let ts2_fts += ['ocaml', 'ruby', 'scheme', 'cabal', 'erlang', 'xml']
let ts2_fts += ['puppet', 'htmldjango', 'json', 'javascript', 'pony']
let ts2_fts += ['cpp', 'capnp', 'unison', 'haskell']

let ts4_fts = ['idris', 'python', 'java', 'julia', 'rust']
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
	au BufRead,BufNewFile *.hsc setlocal ft=haskell
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
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
"let s:opam_share_dir = system("opam config var share")
"let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
"
"let s:opam_configuration = {}
"
"function! OpamConfOcpIndent()
"  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
"endfunction
"let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
"
"function! OpamConfOcpIndex()
"  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
"endfunction
"let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
"
"function! OpamConfMerlin()
"  let l:dir = s:opam_share_dir . "/merlin/vim"
"  execute "set rtp+=" . l:dir
"endfunction
"let s:opam_configuration['merlin'] = function('OpamConfMerlin')
"
"let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
"let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
"let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
"for tool in s:opam_packages
"  " Respect package order (merlin should be after ocp-index)
"  if count(s:opam_available_tools, tool) > 0
"    call s:opam_configuration[tool]()
"  endif
"endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 61160c23c60831495d3343a260806627 ## you can edit, but keep this line
"if count(s:opam_available_tools,"ocp-indent") == 0
"  source "/home/isd/.opam/4.07.0/share/ocp-indent/vim/indent/ocaml.vim"
"endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
