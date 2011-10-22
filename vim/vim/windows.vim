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
noremap <silent> <C-S-LEFT> :vertical resize -5<CR>
noremap <silent> <C-S-DOWN> :resize -5<CR>
noremap <silent> <C-S-RIGHT> :vertical resize +5<CR>
noremap <silent> <C-S-UP> :resize +5<CR>
" Rotate windows
nmap <silent> <S-UP> <C-w>K
nmap <silent> <S-DOWN> <C-w>J
nmap <silent> <S-LEFT> <C-w>H
nmap <silent> <S-RIGHT> <C-w>L



"}}}
