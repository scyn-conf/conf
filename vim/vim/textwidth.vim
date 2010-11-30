" File: textwidth.vim
" Project: scyn-conf/conf/vim
" Brief: Vim textwidth configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Options:{{{
"------------------------------------------------------------------------------
set textwidth=120


"}}}
" Variables:{{{
"------------------------------------------------------------------------------
" Set default textwidth value. Values can be 80, 120 or 160
let g:defaultTextWidth = 120


"}}}
" Functions:{{{
"------------------------------------------------------------------------------
function! s:ToogleTextWidth()
	if g:defaultTextWidth == 80
		silent! exe "set textwidth=120" 
		let g:defaultTextWidth = 120
		echo "Textwidth value is now set to 120"
	elseif g:defaultTextWidth == 120
		silent! exe "set textwidth=160" 
		let g:defaultTextWidth = 160
		echo "Textwidth value is now set to 160"
	elseif g:defaultTextWidth == 160
		silent! exe "set textwidth=80"
		let g:defaultTextWidth = 80
		echo "Textwidth value is now set to 80"
	endif
endfunction


" }}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	ToogleTextWidth		call s:ToogleTextWidth()


"}}}
" Mappings:{{{
"------------------------------------------------------------------------------
noremap <silent>	<F9>			:ToogleTextWidth<CR> 


"}}}
