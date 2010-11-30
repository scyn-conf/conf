" File: goto.vim
" Project: scyn-conf/vim
" Brief: Vim 'goto' configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Mappings:{{{
"------------------------------------------------------------------------------
" Go to file under cursor in a split
noremap <silent>	hgf	:split <cfile><CR>
" Go to file under cursor in a vertical split
noremap <silent>	vgf	:vsplit <cfile><CR>
" Go to file under cursor in a new tab
noremap <silent>	tgf	:tabedit <cfile><CR>


"}}}

