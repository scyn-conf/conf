" File: general.vim
" Project: scyn-conf/vim
" Brief: Vim general configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Minimal number of lines to scroll when the cursor gets of the screen
set scrolloff=16
" Completion mode (behaves like bash)
set wildmode=list:longest
" Patterns to ignore when completing file or directry names
set wildignore=*.o,*.obj,*.bak,*.exe,*~
" ~/.viminfo file settings
set viminfo='1000,f1,:500,/500,<50,s10,h
" :list command configuration
set listchars+=tab:I.,trail:_
" Do not redraw when running macros (much faster)
set lazyredraw
" Number of lines for command line history
set history=500
" Use utf8
set fileencoding=utf8
set encoding=utf8
" Enable filetype plugins
filetype plugin on
" Disable syntax highlighting for lines that are too long (much faster)
set synmaxcol=2048
" Do not continue comments for line created using o or O
set formatoptions-=o
" Don't wrap lines but break lines at convenient points
set nowrap
set linebreak
" Timeout for macros
set timeoutlen=500



