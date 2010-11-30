" File: tags.vim
" Project: scyn-conf/conf/tags.vim
" Brief: Vim tags configuration
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Functions:{{{
"------------------------------------------------------------------------------
function! s:GenerateCtags()
	silent! execute "! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
endfunction

"}}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	GenerateCtags		call s:GenerateCtags()


"}}}
" Mappings:{{{
"------------------------------------------------------------------------------
noremap <silent>	<F6>			:GenerateCtags<CR>


"}}}
