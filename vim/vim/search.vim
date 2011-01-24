" File: search.vim
" Project: scyn-conf/vim
" Brief: Vim search configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Options:{{{
"------------------------------------------------------------------------------
" Ignore case of normal letters in patterns
set ignorecase
" Ignore case when the pattern contains lowercase letters only
set smartcase
" Search wrap around the end of the file
set nowrapscan
" Show the current first match when search"
set incsearch

" }}}
" Mappings:{{{
"------------------------------------------------------------------------------
" disable highlighting : Useful after performing a search
map -- <ESC>:noh<RETURN>

"}}}
