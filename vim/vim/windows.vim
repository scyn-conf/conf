" File: windows.vim
" Project: scyn-conf/conf/vim
" Brief: Vim windows configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Mappings:{{{
"------------------------------------------------------------------------------
" Move between windows
map <silent> <SPACE>k <C-w><up>
map <silent> <SPACE>j <C-w><down>
map <silent> <SPACE>l <C-w><right>
map <silent> <SPACE>h <C-w><left>
" Resize windows
noremap <silent> <C-S-LEFT> :vertical resize -10<CR>
noremap <silent> <C-S-DOWN> :resize -10<CR>
noremap <silent> <C-S-RIGHT> :vertical resize +10<CR>
noremap <silent> <C-S-UP> :resize +10<CR>

"}}}
