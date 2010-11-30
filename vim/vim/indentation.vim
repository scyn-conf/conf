" File: indentation.vim
" Project: scyn-conf/conf/vim
" Brief: Vim indentation configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Options:{{{
"------------------------------------------------------------------------------
" Do NOT insert spaces instead of tabs
set noexpandtab
" Number of spaces in the file a <Tab> counts for.
" (/!\ This value should not be changed!)
set tabstop=8
" Number of columns a <Tab> counts for
set softtabstop=8
" Number of spaces to use for each step of indentation
set shiftwidth=8
" Insert blanks according to shiftwidth, tabstop and softtabstop
set smarttab
" Set auto indentation
set autoindent


"}}}
" Variables:{{{
"------------------------------------------------------------------------------
" Default indent style. Values can be 2, 4 and 8
let g:my_set_style = 2


" }}}
" Functions:{{{
"------------------------------------------------------------------------------
" Allow user to switch between indentation styles
" Note: it does not reindent files
function! s:IndentStyle()
	echo "Styles: "
	echo "	[0] normal-2"
	echo "	[1] normal-4"
	echo "	[2] normal-8 (default)"
	echo "	[3] kernel-8"
	let g:indent_style=input ("Specify indenting style : ")
	if g:indent_style < 3
		set noexpandtab
		set tabstop=8
		set smarttab
		set comments=sl:/*,mb:**,ex:*/
		let g:DoxygenToolkit_interCommentTag = "** "
		let g:DoxygenToolkit_interCommentBlock = "** "
		let g:DoxygenToolkit_cinoptions = "c0C1"
		if g:indent_style == 0
			set softtabstop=2
			set shiftwidth=2
			echo "normal-2 (indent=tab, len=2, tab_display=8)"
		else
			if g:indent_style == 1
				set softtabstop=4
				set shiftwidth=4
				echo "normal-4 (indent=tab, len=4, tab_display=8)"
			else 
				if g:indent_style == 2
					set softtabstop=8
					set shiftwidth=8
					echo "normal-8 (indent=tab, len=8, tab_display=8)"
				endif
			endif
		endif
	else
		if g:indent_style == 3
			set noexpandtab
			set softtabstop=8
			set tabstop=8
			set shiftwidth=8
			set smarttab
			set comments=sl:/*,mb:\ *,ex:\ */
			let g:DoxygenToolkit_interCommentTag = "* "
			let g:DoxygenToolkit_interCommentBlock = "* "
			let g:DoxygenToolkit_cinoptions = "c1C1"
			echo "kernel-8 (indent=tab, len=8, tab_display=8)"
		endif
	endif
endfunction


" Display tabs
function! s:SeeTabs()
	if !exists("g:SeeTabEnabled")
		let g:SeeTabEnabled = 1
		let g:SeeTab_list = &list
		let g:SeeTab_listchars = &listchars
		let regA = @a
		redir @a
		silent! hi SpecialKey
		redir END
		let g:SeeTabSpecialKey = @a
		let @a = regA
		silent! hi SpecialKey guifg=#555555 guibg=NONE gui=NONE ctermfg=darkgray ctermbg=NONE        cterm=NONE
		set list
		set listchars=tab:\|\ 
	else
		let &list = g:SeeTab_list
		let &listchars = &listchars
		silent! exe "hi ".substitute(g:SeeTabSpecialKey,'xxx','','e')
		unlet g:SeeTabEnabled g:SeeTab_list g:SeeTab_listchars
	endif
endfunction


" Reindent current file
function! s:ReindentFile()
  silent! execute "normal ggvG=``"
endfunction


"}}}"
" Commands: {{{
"------------------------------------------------------------------------------
command! -nargs=0	ReindentFile	call s:ReindentFile()
command! -nargs=0	SeeTabs		call s:SeeTabs()
command! -nargs=0	IndentStyle	call s:IndentStyle()


"}}}
" Mappings:{{{
"------------------------------------------------------------------------------
" Reindent current file
noremap <silent>	<F12>	:ReindentFile<CR>
noremap <silent>	==	:ReindentFile<CR>
" SeeTabs mapping
noremap <silent>	<F11>	:SeeTabs<CR>
" IndentStyle mapping
noremap <silent>	<F10>	:IndentStyle<CR>


"}}}


