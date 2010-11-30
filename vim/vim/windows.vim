" File: windows.vim
" Project: scyn-conf/conf/vim
" Brief: Vim windows configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Mappings:{{{
"------------------------------------------------------------------------------
" Move between windows
noremap <silent> <SPACE>k <C-w><up>
noremap <silent> <SPACE>j <C-w><down>
noremap <silent> <SPACE>l <C-w><right>
noremap <silent> <SPACE>h <C-w><left>
" Resize windows
noremap <silent> <C-S-LEFT> :vertical resize -10<CR>
noremap <silent> <C-S-DOWN> :resize -10<CR>
noremap <silent> <C-S-RIGHT> :vertical resize +10<CR>
noremap <silent> <C-S-UP> :resize +10<CR>

"}}}
