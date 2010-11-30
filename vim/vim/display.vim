" File: display.vim
" Project: scyn-conf/conf/vim
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
set statusline=%r%m\ %n:%f\ %l,%c\ (%p%%/%LL)
" Always display statusline
set laststatus=2
" Get rid of separator chars
set fillchars=""


"}}}
" Variables:{{{
let g:SyntaxDebug = 0
let g:CharAnalysis = 0


"}}}
" Functions:{{{
"------------------------------------------------------------------------------
" Toogle syntax debug in status line (highlight groups)
function! s:ToogleSyntaxAnalysis()
	let g:SyntaxDebug = !g:SyntaxDebug
	call s:UpdateStatusLine()
endfunction

" Toogle character analysis in status line (display dec/hex char values)
function! s:ToogleCharAnalysis()
	let g:CharAnalysis = !g:CharAnalysis
	call s:UpdateStatusLine()
endfunction

" Reset status line
function! s:ResetStatusLine()
	let g:SyntaxDebug = 0
	let g:CharAnalysis = 0
endfunction

" Update status line
function! s:UpdateStatusLine()
	set statusline=%r%m\ %n:%f\ %l,%c\ (%p%%/%LL)

	if g:SyntaxDebug == 1
		set statusline+=\ %{SyntaxDebug()}
	endif
	if g:CharAnalysis == 1
		set statusline+=\ \ \ \[%o:%b/0x%B]
	endif
endfunction

"}}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	ToogleSyntaxAnalysis		call s:ToogleSyntaxAnalysis()
command! -nargs=0	ToogleCharAnalysis              call s:ToogleCharAnalysis()
command! -nargs=0	ResetStatusLine                 call s:ResetStatusLine()


"}}}


