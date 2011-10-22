" File: editing.vim
" Project: scyn-conf/vim
" Brief: Vim edition configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Variables:{{{
"------------------------------------------------------------------------------
let g:spellCheckingState = 0

" }}}
" Functions:{{{
"------------------------------------------------------------------------------
function! s:DeleteTrailingWhiteSpaces()
	silent! execute "%substitute/\\s\\+$//"
	noh    
endfunction  

function! s:ToogleSpellChecking()
	if g:spellCheckingState == 0
		silent! execute "set nospell"
		let g:spellCheckingState = 1
		echo "Spell checking disabled."
	elseif g:spellCheckingState == 1
		silent! execute "set spell spelllang=fr"
		let g:spellCheckingState = 2
		echo "Spell checking enabled [fr]."
	else
		silent! execute "set spell spelllang=en"
		let g:spellCheckingState = 0
		echo "Spell checking enabled [en]."
	endif
endfunction


" }}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	DeleteTrailingWhiteSpaces	:call s:DeleteTrailingWhiteSpaces()
command! -nargs=0	ToogleSpellChecking		:call s:ToogleSpellChecking()

" }}}
" Mappings:{{{
" Toogle spell checking
noremap <silent>	<F4>		:ToogleSpellChecking<CR>
" Delete trailing whitespaces
noremap <silent>	<F6>		:DeleteTrailingWhiteSpaces<CR>
noremap <silent>	-tw		:DeleteTrailingWhiteSpaces<CR>
" }}}

