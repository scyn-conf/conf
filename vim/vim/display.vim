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
" Set colorscheme
" Gui configuration
if has("gui_running")
    set guioptions-=m	" no menu bar
    set guioptions-=T	" no toolbar
    set guioptions-=r	" no right-hand scrollbar
    set guioptions-=L	" no left-hand scrollbar
    set cursorline	" currrent line is highlighted
    set hlsearch	" highlight search matches
    colorscheme scyn_pale " set colorscheme
else " terminal configuration
    set t_Co=16		" Use 8 colors
    colorscheme scyn_pale " set colorscheme
endif
" Show the cursor position
set ruler
" Show line numbers
set number
" Status line
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
" Always display statusline
set laststatus=2
" Get rid of separator chars
set fillchars=""


"}}}
" Variables:{{{
let g:SyntaxDebug=0


"}}}
" Functions:{{{
"------------------------------------------------------------------------------
" Toogle syntax debug status line
function! s:ToogleSyntaxDebugStatusLine()
	if g:SyntaxDebug == 0
		set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %{SyntaxDebug()}
	else
		set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
	endif
	let g:SyntaxDebug = !g:SyntaxDebug
endfunction


"}}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	ToogleSyntaxDebug		call s:ToogleSyntaxDebugStatusLine()


"}}}


