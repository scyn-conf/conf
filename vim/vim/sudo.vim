" File: sudo.vim
" Project: scyn-conf/sudo.vim
" Brief: Vim sudo configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Functions:{{{
"------------------------------------------------------------------------------
" Allow user in sudoers to write file even if vim wasn't started with root permissions.
function! s:SudoWrite()
	silent! execute "normal :w ! sudo tee %"
endfunction


" }}}
" Commansd:{{{
"------------------------------------------------------------------------------
command! -nargs=0	SudoWrite	call s:SudoWrite()

"}}}
