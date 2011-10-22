" File: display.vim
" Project: scyn-conf/vim
" Brief: Vim display and appearance configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Options:{{{
"------------------------------------------------------------------------------
" Enable syntax
syntax on
" Disable visualbell and beeps
set novb
set t_vb=
" Show incomplete commands
set showcmd
" Show current mode
set showmode
" Gui configuration
if has("gui_running")
    set guioptions-=m	" no menu bar
    set guioptions-=T	" no toolbar
    set guioptions-=r	" no right-hand scrollbar
    set guioptions-=L	" no left-hand scrollbar
    set cursorline	" currrent line is highlighted
    set hlsearch	" highlight search matches
    colorscheme spring	" set colorscheme
else " terminal configuration
    set t_Co=16		" Use 16 colors
    colorscheme spring
endif
" Show the cursor position
set ruler
" Show line numbers
set number
" Get rid of separator chars
set fillchars=""
" Set tab labels
set guitablabel=[%n:%t]


"}}}

