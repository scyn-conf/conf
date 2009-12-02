" vim600: set foldmethod=marker:
"
" File: svn.vim
" Brief: svn integration plugin for vim
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
" Url: http:/github.com/scyn-conf/svn-vim
"


" Section: Variable initialization {{{1
"
" Function: s:_initializeVariable () {{{2
" This function is intended to provide variable initialization, only in the case
" the variable does not exist.
" Args:
" variable: a string containing the name of the variable to be initialized
" value: the value the variable should be initialized to
" Returns:
" 1 if the variable was correctly set, 0 otherwise
function s:_initializeVariable (variable, value)
	if !exists (a:variable)
		exec "let " . a:variable . " = '" . a:value . "'"
		return 1
	endif
	return 0
endfunction

" Function: s:_modifyVariable () {{{2
function s:_modifyVariable (variable, value)
	let oldValue = exists (a:variable) ? a:variable ? -1
	exec "let " . a:variable . " = '" . a:value . "'"
	return oldValue
endfunction


" Section: initializations {{{2
call s:_initializeVariable ("g:SvnBufferLocation", "left")
call s:_initializeVariable ("g:SvnBufferOrientation", "vertical")
call s:_initializeVariable ("g:SvnBufferSize", '')
call s:_initializeVariable ("g:SvnBufferIsHidden", 1)
call s:_initializeVariable ("g:SvnBufferShowLines", 0)
call s:_initializeVariable ("g:SvnBinary", '/usr/bin/svn')
call s:_initializeVariable ("g:SvnVimDiffStyle", "tab")



" Section: Utility functions {{{1
"
" Function: s:_getKey () {{{2
" This function search for key in dictionnary.
" Args:
" key: the key to look for
" dict: the dictionnary to search in
" Returns:
" The value of the key if the dictionnary has it, 0 otherwise
function! s:_getKey(key, dict)
	if has_key (a:dict, a:key)
		return a:dict[a:key]
	else
		return 0
	endif
endfunction


" Function: s:_changeDirectory () {{{2
" Change cwd to dir argument.
" Args:
" dir: the new cwd
" Returns:
" the old working directory
function! s:_changeDirectory(dir)
	" If it is a file, use s:_changeDirectory instead
	if !isdirectory (dir)
		return s:_changeDirectory (s:_getFileDir (a:dir))
	let oldCwd = getcwd ()
	let cmd = 'cd'
	" if the the current window has set a local path, use it
	if exists ("*haslocaldir") && haslocaldir ()
		let cmd = 'lcd'
	endif
	execute cmd escape (a:dir, ' ')
	return oldCwd
endfunction


" Function: s:_getAbsolutePath () {{{2
" Returns: the absolute path of the argument file
function! s:_getAbsolutePath(file)
	return fnamemodify (bufname(a:file), ':p')
endfunction


" Function: s:_getRelativePath () {{{2
" Returns: the relative path of the argument file
function! s:_getRelativePath(file)
	return fnamemodify (bufname(a:file), ':p:.')
endfunction


" Function: s:_getFileDir () {{{2
" Returns: the directory containing the argument file (relative path)
function! s:_getFileDir(file)
	return fnamemodify (bufname(a:file), ':h')
endfunction


" Function: s:_getFileName () {{{2
" Returns: the name of the argument file
function! s:_getFileName(file)
	return fnamemodify (bufname(a:file), ':t')
endfunction


" Function: s:SvnCheckDir () {{{2
" This function is intended to check if a directory contains a working copy (i.e
" if it contains a .svn directory)
" Args:
" dir: a string containing the path of the directory to check
" Returns:
" 1 if the directory contains a working copy, 0 otherwise
function! s:SvnCheckDir (dir)
	let svnDir = getcwd ()
	if  a:dir != '.' && isdirectory(a:dir)
		let svnDir = a:dir
	endif
	if strlen (svnDir) > 0
		let svnDir = svnDir . '/.svn'
	else
		let svnDir = '.svn
	endif
	return isdirectory (svnDir) ? 1 : 0
endfunction


" Function: s:SvnCheckBufferPath () {{{2
" This function is intended to check if the file associated to a buffer is in a
" workin copy.
" Args:
" buffer: the buffer containing the file to be checked.
" Returns:
" 1 if the file is in a working directory, 0 otherwise
function! s:SvnCheckBufferPath (buffer)
	let filename = resolve (bufname(a:buffer))
	if isdirectory(filename)
		return s:SvnCheckDir (filename)
	else
		return s:SvnCheckDir (fnamemodify (filename, ':p:h'))
	endif
endfunction


" Function: s:_createBuffer () {{{2"{{{
" This function creates a new buffer, using plugin variables."}}}
" The new buffer will contain the content argument
" Args:
" content: the content the new buffer should contain
" name: The name of the new buffer
function! s:_createBuffer (content, name, options)
	if a:content == 'Error'
		return
	endif
	" Create the buffer
	let buf_location = (g:SvnBufferLocation == "left") ? "topleft " : "topright "
	let buf_orientation = (g:SvnBufferOrientation == "vertical") ? "vertical " : ""
	let buf_size = g:SvnBufferSize

	let cmd = buf_location . buf_orientation . buf_size . ' new ' . a:name
	silent! execute cmd
	" Throwaway buffer options if necessary. This can be very useful for
	" other plugins like FuzzyFinder or BufExplorer, as you don't necessary
	" want this buffer to appear in the buffer list.
	if g:SvnBufferIsHidden
		setlocal nobuflisted
	endif
	setlocal buftype=acwrite
	setlocal readonly
	setlocal bufhidden=delete
	setlocal noswapfile
	setlocal nowrap
	setlocal foldcolumn=0
	setlocal nospell
	if g:SvnBufferShowLines
		setlocal nu
	else
		setlocal nonu
	endif
	
	setlocal modifiable
	" Put the content into the new buffer
	silent put=a:content
	goto 1
	delete	
	augroup SvnBufferDelete
		au!
		au BufDelete * call s:_bufferDelete ()
	augroup END

	set nomodified
	" Set the filetype of the new buffer to svnplugin
	"setfiletype svnplugin
	"if has ("syntax") && exists ("g:syntax_on") && !has ("syntax_items")
	"	FIXME
	"endif
endfunction


function! s:_bufferDelete ()
	set nonu
	if g:SvnBufferShowLines
		set nu
	endif
endfunction

" Function: s:SvnGetCommandArg () {{{2
" This function is intended to get the argument of the command to be executed,
" using the options argument. The argument depend on the scope of the command,
" ie if it is applied to the current file, the current file's directory, or the
" current working directory
" Args:
" options: dictonnary containing commmand execution related options.
" Returns:
" A relative path to a file or a directory if the command is local to a file or
" directory, an empty string otherwise.
function! s:SvnGetCommandArg (options)
	" if the arguments are already filled, return them
	" else retrieve informations about the scope of the command
	let dir_scope = s:_getKey ('_localDir', a:options)
	let file_scope = s:_getKey ('_localFile', a:options)
	" Get the argument
	if file_scope
		let filename = s:_getRelativePath ('%')
		return  isdirectory (filename) ? " " : filename
	elseif dir_scope
		let dir = s:_getFileDir ('%')
		return isdirectory (dir) ? dir : " "
	endif
	return " "
endfunction


" Function: s:SvnExecuteCommand () {{{2
" This function performs several actions:
" - It first retrieves informations about the command to be executed, such as
"   its scope, then change working directory accordingly and update command to
"   be executed.
" - It executes the command, outputing errors and resetting working after the
"   command terminate.
" Args:
" cmd: string containing the command to be executed
" options: dictionnary containing command execution related options, such as its
" scope.
" Returns:
" A string containing svn output, 'Error' otherwise.
function! s:SvnExecuteCommand(cmd, args, options)
	" Retrieve command execution options
	let allowNonZeroExit = s:_getKey ('_allowNonZeroExit', a:options)
	" Build command to execute
	let fullCmd = a:cmd . " " . a:args . " " . s:SvnGetCommandArg (a:options)
	" Execute the command
	let svn_output = system (g:SvnBinary . " " . fullCmd)
	" if an error occured, output error, else return svn output
	if v:shell_error && !allowNonZeroExit
		echohl Error
		echo svn_output
		echohl None
		return 'Error'
	else
		return svn_output
	endif
endfunction




" Section: Svn functions implementation {{{1
"
" Function: s:SvnAdd () {{{2
function! s:SvnAdd (args, options)
	let result = s:SvnExecuteCommand ('add', a:args, a:options)
	call s:_createBuffer (result, '_svn_add', {})
	setlocal filetype=svn
endfunction


" Function: s:SvnBlame () {{{2
function! s:SvnBlame (args, options)
	let result = s:SvnExecuteCommand ('blame', a:args, a:options)
	call s:_createBuffer (result, '_svn_blame', {})
endfunction


" Function: s:SvnInfo () {{{2
function! s:SvnInfo (options)
	
endfunction


" Function: s:SvnStatus () {{{2
function! s:SvnStatus(args, options)
	let result = s:SvnExecuteCommand ('status --non-interactive', a:args, a:options)
	call s:_createBuffer (result, '_svn_status', {})
	setlocal filetype=svn
endfunction


" Function: s:SvnLog () {{{2
function! s:SvnLog(args, options)
	let result = s:SvnExecuteCommand ('log --verbose ' , a:args, extend(a:options, {'_allowNonZeroExit' : 1}))
	call s:_createBuffer (result, '_svn_log', {})
	setlocal filetype=changelog
endfunction


" Function: s:SvnUpdate () {{{2
function! s:SvnUpdate(args, options)
	let result = s:SvnExecuteCommand ('update --non-interactive', a:args, a:options)
	checktime
	call s:_createBuffer (result, '_svn_update', {})
	setlocal filetype=svn
endfunction



" Function: s:SvnCommit () {{{2
function! s:SvnCommit(args, options)
	" Create commit buffer
	let commit_msg = "--This line, and those below, will be ignored--\n\n" . 
				\ s:SvnExecuteCommand ('status -q --non-interactive', a:args, a:options)
	let commit_arg = a:args . " " . s:SvnGetCommandArg (a:options)
	call s:_createBuffer (commit_msg, '_svn_commit', {})
	setlocal modifiable noreadonly
	augroup SvnCommit
		" When the buffer is written, override its behavior
		execute printf ("autocmd BufWriteCmd <buffer> call s:SvnCommitWrite ('%s') | autocmd! SvnCommit * <buffer>", commit_arg)
	augroup END
	" Go to first line
	goto 1
	setlocal filetype=svn
endfunction


" Function: s:SvnCommitWrite ()
function! s:SvnCommitWrite(arg)
	" Retrieve commit buffer
	let commitBuffer = bufnr('_svn_commit')
	setlocal nomodified
	" Delete epilogue
	%substitute/\-\-[^$]*\-\-\n\(.*\n\)*//g
	" Get the lines of the commit buffer
	let commitMessage = getbufline('%', 1, '$')
	" Write into temporary file rather than original file
	let tmpFile = tempname ()
	call writefile (commitMessage, tmpFile)
	" Execute commit
	let result = s:SvnExecuteCommand ('commit -F ' . tmpFile, a:arg, {})
	call delete (tmpFile)
	if !v:shell_error
		execute 'bw!' commitBuffer
	endif
endfunction


" Function: s:SvnCat () {{{2
function! s:SvnCat(args, options)
	" If interactive option is set, ask for revision
	if s:_getKey ('_isInteractive', a:options)
		let rev = input ('Revision (Enter for current): ')
	else
		let rev = ""
	endif
	if rev != ""
		let rev_arg = " -r " . rev . " "
	else
		let rev_arg = ""
	endif 
	" Retrieve filename
	" This also allows to keep informations such as filetype
	if s:_getKey ('_localFile', a:options)
		let target = '%'
	else
		let target = a:args
	endif
	let fileName = fnamemodify (bufname (target), ':p:r')
	let fileName .= "[" . (rev != "" ? rev : "current") . "]"
	let extension = fnamemodify (bufname (target), ':e')
	let fileName .= extension == "" ? extension : ("." . extension)
		
	let result = s:SvnExecuteCommand ('cat', rev_arg . a:args, a:options)
	call s:_createBuffer (result, fileName, {})
endfunction


" Function: s:SvnDiff () {{{2
function! s:SvnDiff(args, options)
	let result = s:SvnExecuteCommand ('diff', a:args, a:options)
	call s:_createBuffer (result, '_svn_diff', {})
	setlocal filetype=diff
endfunction

" Function: s:SvnVimDiff () {{{2
function! s:SvnVimDiff(args, options)
	if g:SvnVimDiffStyle == "tab"
		execute "tabedit %"
	endif
	diffthis
	call s:SvnCat (a:args, a:options)
	diffthis
	augroup SvnVimDiff
		au!
		au BufUnload * call s:SvnVimDiffOff(str2nr(expand('<abuf>')))
	augroup END
endfunction

" Function: s:SvnVimDiffOff ()
function! s:SvnVimDiffOff(arg)
	diffoff
	if g:SvnVimDiffStyle == "tab"
		execute "quit!"
	endif
endfunction

" Section: Commands definition {{{1

" Section: SvnAdd {{{2
command! -nargs=* -complete=file	SvnAdd		call s:SvnAdd (<q-args>, {})
command! -nargs=0			SvnAddFile	call s:SvnAdd ('', {'_localFile' : 1})
command! -nargs=0			SvnAddDir	call s:SvnAdd ('', {'_localDir' : 1})

" Section: SvnBlame {{{2
command! -nargs=* -complete=file	SvnBlame	call s:SvnBlame (<q-args>, {})
command! -nargs=*			SvnBlameFile	call s:SvnBlame (<q-args>, {'_localFile' : 1})

" Section: SvnStatus {{{2
command! -nargs=* -complete=file	SvnStatus	call s:SvnStatus (<q-args>, {})
command! -nargs=0 			SvnStatusFile	call s:SvnStatus ('', {'_localFile' : 1})
command! -nargs=0 			SvnStatusDir	call s:SvnStatus ('', {'_localDir' : 1})

" Section: SvnUpdate {{{2
command! -nargs=* -complete=file	SvnUpdate	call s:SvnUpdate (<q-args>, {})
command! -nargs=* 			SvnUpdateFile	call s:SvnUpdate (<q-args>, {'_localFile' : 1})
command! -nargs=* 			SvnUpdateDir	call s:SvnUpdate (<q-args>, {'_localDir' : 1})

" Section: SvnLog {{{2
command! -nargs=* -complete=file	SvnLog		call s:SvnLog (<q-args>, {})
command! -nargs=* 			SvnLogFile	call s:SvnLog (<q-args>, {'_localFile' : 1})
command! -nargs=* 			SvnLogDir	call s:SvnLog (<q-args>, {'_localDir' : 1})

" Section: SvnCat {{{2
command! -nargs=1 -complete=file	SvnCat		call s:SvnCat (<q-args>, {'_isInteractive' : 1})
command! -nargs=0 -complete=file	SvnCatFile	call s:SvnCat ('', {'_localFile' : 1, '_isInteractive' : 1})

" Section: SvnDiff {{{2
command! -nargs=* -complete=file	SvnDiff		call s:SvnDiff (<q-args>, {})
command! -nargs=*			SvnDiffFile	call s:SvnDiff (<q-args>, {'_localFile' : 1})
command! -nargs=*			SvnDiffDir	call s:SvnDiff (<q-args>, {'_localDir' : 1})
"command! -nargs=* -complete=file	SvnvimDiff	call s:SvnDiff (<q-args>, {})
command! -nargs=0			SvnVimDiffFile	call s:SvnVimDiff (<q-args>, {'_localFile' : 1})
"command! -nargs=*			SvnVimDiffDir	call s:SvnDiff (<q-args>, {'_localDir' : 1})

" Section: SvnCommit {{{2
command! -nargs=* -complete=file 	SvnCommit	call s:SvnCommit(<q-args>, {})
command! -nargs=0 			SvnCommitFile	call s:SvnCommit(<q-args>, {'_localFile' : 1})
command! -nargs=0 			SvnCommitDir	call s:SvnCommit(<q-args>, {'_localDir' : 1})
