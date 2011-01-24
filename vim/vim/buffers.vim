" File: buffers.vim
" Project: scyn-conf/vim
" Brief: Vim buffers configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Allow to change buffer without saving
set hidden
" Allow vim to update file without asking
set autoread

" Cycle through buffers
map <S-LEFT> <ESC>:bp<RETURN>
map <S-RIGHT> <ESC>:bn<RETURN> 

" BufExplorer
nmap <silent> <unique> <SPACE><SPACE> :BufExplorer<CR>

