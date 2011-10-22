" File: statusline.vim
" Project: scyn-conf/vim
" Brief: Vim statusline configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"


" Options:{{{
"------------------------------------------------------------------------------
" Status line
set statusline=%r%m%n:%f
set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*
set statusline+=\ (%p%%/%LL)\ %l,%c

" Always display statusline
set laststatus=2



"}}}
" Variables:{{{
"------------------------------------------------------------------------------
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
	let g:SyntaxChecking = 0
endfunction

" Update status line
function! s:UpdateStatusLine()
	set statusline=%r%m%n:%f
	if g:SyntaxDebug == 1
		set statusline+=\ %{SyntaxDebug()}
	endif
	if g:CharAnalysis == 1
		set statusline+=\ \ \ \[%o:%b/0x%B]
	endif
	set statusline+=%=
	set statusline+=%#errormsg#
	set statusline+=%{StatuslineTrailingSpaceWarning()}
	set statusline+=%{StatuslineLongLineWarning()}
	set statusline+=%{StatuslineTabWarning()}
	set statusline+=%*
	set statusline+=\ (%p%%/%LL)\ %l,%c

endfunction

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
	if !exists("b:statusline_trailing_space_warning")
		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif
		if search('\s\+$', 'nw') != 0
			let b:statusline_trailing_space_warning = '[\s]'
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
	if !exists("b:statusline_tab_warning")
		let b:statusline_tab_warning = ''
		if !&modifiable
			return b:statusline_tab_warning
		endif
		let tabs = search('^\t', 'nw') != 0
		"find spaces that arent used as alignment in the first indent column
		let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
		if tabs && spaces
			let b:statusline_tab_warning =  '[mixed-indenting]'
		elseif (spaces && !&et) || (tabs && &et)
			let b:statusline_tab_warning = '[&et]'
		endif
	endif
	return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
	if !exists("b:statusline_long_line_warning")
		if !&modifiable
			let b:statusline_long_line_warning = ''
			return b:statusline_long_line_warning
		endif
		let long_lines = s:LongLines()
		let threshold = (&tw ? &tw : 80)
		if len(long_lines) > 0
			let b:statusline_long_line_warning = "[" .
			\ "&tw l" . long_lines[0][0] . " (" . long_lines[0][1] . "/" . threshold . ") "
			\ . len(long_lines) . "+]"
		else
			let b:statusline_long_line_warning = ""
		endif
	endif
	return b:statusline_long_line_warning
endfunction

"return a list containing tuples with the line number and the length of the long lines
function! s:LongLines()
	let threshold = (&tw ? &tw : 80)
	let spaces = repeat(" ", &ts)
	let long_line_lens = []

	let i = 1
	while i <= line("$")
"		let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
		let len = strlen(getline(i))
		if len > threshold
			call add(long_line_lens, [i, len])
		endif
		let i += 1
	endwhile
	return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
	let nums = sort(a:nums)
	let l = len(nums)

	if l % 2 == 1
		let i = (l-1) / 2
		return nums[i]
	else
		return (nums[l/2] + nums[(l/2)-1]) / 2
	endif
endfunction


"}}}
" Commands:{{{
"------------------------------------------------------------------------------
command! -nargs=0	ToogleSyntaxAnalysis		call s:ToogleSyntaxAnalysis()
command! -nargs=0	ToogleCharAnalysis              call s:ToogleCharAnalysis()
command! -nargs=0	ResetStatusLine                 call s:ResetStatusLine()

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning




"}}}


