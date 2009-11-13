" File: fun.vim
" Brief: Functions used in vim configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
"
" Use tab to insert tab or completion.
function MayComplete()
	let col = col('.')-1
	if !col || getline('.')[col-1] !~ '\k'
		return "\<Tab>"
	else
		return "\<C-N>"
	endif
endfunction


let g:my_set_style = 2
function! My_indent_style()
	echo "Styles: "
	echo "	[0] normal-2 (default)"
	echo "	[1] normal-4"
	echo "	[2] normal-8"
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

fu! SeeTab()
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
endfunc


let g:defaultTextWidth = 1
function! ToogleTextWidth ()
	if g:defaultTextWidth == 1
		silent! exe "set textwidth=80" 
		let g:defaultTextWidth = 0
		echo "Textwidth value is now set to 80"
	else
		silent! exe "set textwidth=200"
		let g:defaultTextWidth = 1
		echo "Textwidth value is now set to 200"
	endif
endfunction


