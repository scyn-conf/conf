" File: syntax.vim
" Project: scyn-conf/vim
" Brief: Vim syntax related configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Functions:{{{
"------------------------------------------------------------------------------
" Display current highlight
function! SyntaxDebug()
	echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"
endfunction


"}}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	SyntaxDebug	call SyntaxDebug()


"}}}
