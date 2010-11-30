" File: editing.vim
" Project: scyn-conf/editing.vim
" Brief: Vim edition configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Functions:{{{
"------------------------------------------------------------------------------
function! s:DeleteTrailingWhiteSpaces()
	silent! execute "normal :%s/\s\+$//<CR>``:noh<CR>"
endfunction


" }}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	DeleteTrailingWhiteSpaces	:call s:DeleteTrailingWhiteSpaces()

" }}}
" Mappings:{{{
" Delete trailing whitespaces
noremap <silent>	<F6>		:DeleteTrailingWhiteSpaces<CR>
noremap <silent>	-tw		:DeleteTrailingWhiteSpaces<CR>
" }}}

