" File: .vimrc
" Brief: Vim configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMPATIBILITY /!\ These settings shouldn't be altered
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible
if v:progname =~? "evim"
    finish
endif
if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
	au!
	autocmd FileType text setlocal textwidth=78
	autocmd BufReadPost *
		    \ if line("'\"") > 0 && line("'\"") <= line("$") |
		    \   exe "normal g`\"" |
		    \ endif
    augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup	" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif

set showcmd		" display incomplete commands
set scrolloff=2
set wildmode=longest,list
set viminfo='1000,f1,:500,/500,<50,s10,h
set listchars+=tab:I.,trail:_
set nowrap
set wildignore=*.o,*.obj,*.bak,*.exe,*~
set lz			" do not redraw while running macros (much faster) (LazyRedraw)
set hid			" you can change buffer without saving
set autoread		" update file without asking


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme ir_black 	" color file (See ~/.vim/colors/)
if &t_Co > 2 || has("gui_running")
    "" Comment or Uncomment this line according to your terminal configuration
    "" (256 colors or not)
    "set t_Co=256
    syntax on
    set hlsearch
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
set cursorline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ENCODING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencoding=utf8
filetype plugin on
set encoding=utf8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENTATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noexpandtab
set softtabstop=2
set tabstop=8 
set shiftwidth=2
set smarttab
set autoindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FORMATING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=80
highlight col79 ctermbg=Red guibg=Red


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set nowrapscan
set incsearch		" do incremental searching


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/fun.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
source ~/.vim/langdep.vim

