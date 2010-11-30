" autofile.vim (vim plugin to automatically fill files and update headers)
" Maintainer: Matias Larre Borges <matias.larreborges@gmail.com>
" Last Change: 2008 Sep 21

" Exit quickly when already loaded or when 'compatible' is set.
if exists('loaded_autoheaders') || &compatible
  finish
endif
let loaded_autoheaders = 1

" configuration
" -------------

" sets date format (see strftime man pages) [
"   Examples: %Y %b %e       : 2008 Aug 18
"             %a %b %e %T %Y : Mon Aug 18 04:53:53 2008 -- EPITA ]
let s:date_format = '%a %b %e %T %Y' 

" sets last change information string [
"   Examples: 'Last [cC]hange: ', 
"             'Last [uU]pdate ' -- EPITA,
"             ... ]
let s:last_change_str = 'Last [uU]pdate: '

" sets folder where skeleton files are stored
let s:skel_dir = '$HOME/.vim/bundle/autofile/skel/'

let s:me_name = exists('g:me_name') ? g:me_name : 'John Doe'
let s:me_mail = exists('g:me_mail') ? g:me_mail : 'j.doe@nomail.com'


" sets the dictionary of the fields recognized in the templates
let s:fields = {
      \'@FILE-NAME@'    : "expand('%:t')",
      \'@USER-MAIL@'    : "s:me_mail",
      \'@USER-NAME@'    : "s:me_name",
      \'@USER-LOGIN@'   : "$USER",
      \'@DATE-STAMP@'   : "strftime(s:date_format)",
      \'@PWD@'          : "$PWD",
      \'@HFILE-NAME@'    : "toupper(substitute(expand('%:t'), '[.-]', '_', 'g'))",
      \'@PROJECT@'      : "input('Nom du projet: ')",
      \}

if has('autocmd')
  aug filecreations
    " Vim files
    au BufNewFile *.vim   call Add_Header('gen_header.tpl', '"')

    " C Files (*.c, *.h) -- EPITA
    au BufNewFile *.c call Add_Header('epita_header.tpl', '/*', '**', '*/')
    au BufNewFile *.h call Add_Templates('epita_header.tpl _h.tpl', '/*', '**', '*/')

    " Shell files
    au BufNewFile *.sh call Add_Header('gen_header.tpl', '#', '#', '#')
    au BufNewFile *.zsh call Add_Header('gen_header.tpl', '#', '#', '#')
    

  aug END
"" EDIT[scyn]: Desactivate headers updates as I modified the templates to get
"" rid of the timestamps, which were causing problems for vcs.
""
"  aug fileupdates
"    " vim files
"    au BufWritePre *.vim       call Update_Header()
"
"    " conf files
"    au BufWritePre *.conf      call Update_Header()
"
"    " user configuration files
"    au BufWritePre .*rc        call Update_Header()
"
"    " Makefiles
"    "au BufWritePre [Mm]akefile call Update_Header()
"
"    " C Files (*.c, *.h) -- EPITA
"    au BufWritePre *.c,*.h     call Update_Header(strftime(s:date_format). ' ' . g:me_name)
"  aug END
endif

" code
" ----

" Function: s:ReplaceField(pattern, str)
" Description:
function s:ReplaceField(pattern, str)
  execute "silent!, % s," . a:pattern . "," . a:str . ",ge" 
endfun

" Function: ReplaceFields(cs, cm, ce)
" Description:
function ReplaceFields(cs, cm, ce)
  call s:ReplaceField ('@CS@', a:cs)
  call s:ReplaceField ('@CM@', a:cm)
  call s:ReplaceField ('@CE@', a:ce)
  for key in keys(s:fields)
    execute 'call s:ReplaceField("' . key . '",' . s:fields[key] . ')'
  endfor
endfun

" Function: Add_Header(header_file, ...)
" Description:
function Add_Header(header_file, ...)
  execute "0r " . s:skel_dir . a:header_file
  if a:0 == 3
    call ReplaceFields(a:1, a:2, a:3)
  elseif a:0 == 1
    call ReplaceFields(a:1, a:1, a:1)
  else
    throw "invalid number of arguments, only 1 or 3 accepted"
  endif
  normal G
endfun

" Function: Add_Templates(template_list, ...)
" Description:
function Add_Templates(template_list, ...)
  let l:list = reverse(split(a:template_list))
  for template in l:list
    execute "0r " . s:skel_dir . template
  endfor
  if a:0 == 3
    call ReplaceFields(a:1, a:2, a:3)
  elseif a:0 == 1
    call ReplaceFields(a:1, a:1, a:1)
  else
    throw "invalid number of arguments, only 1 or 3 accepted"
  endif
  normal G
endfun

" Function: Update_Header(...)
" Description: 
function Update_Header(...)
  try
    " Breaking up saving the position [
    "   ms - store cursor position in the 's' mark
    "   M  - go to the line in the middle of window
    "   mt - store this position in the 't' mark ]
    normal msMmt
    " Updates the first occurence of "Last [cC]hange: .*"
    if a:0 == 0
      execute "silent!, 0;/" . s:last_change_str . "/ s,\\(" . s:last_change_str . "\\).*,\\1" . strftime(s:date_format) . ",e"
    elseif a:0 == 1
      execute "silent!, 0;/" . s:last_change_str . "/ s,\\(" . s:last_change_str . "\\).*,\\1" . a:1 . ",e"
    endif
    " Breaking up restoring the position [
    "   't - go to the line previously at the center of the window
    "   z. - scroll to move this line to the center of the window
    "   `s - jump to the original position of the cursor ]
    normal 'tz.`s
  catch
    echoerr "autofile.vim: " . v:exception
  endtry
endfun

" Function: Add_Body(body_file)
" Description: 
function Add_Body(body_file)
  " Go to the end of file
  normal G
  execute "r " . s:skel_dir . a:body_file
endfun

" END
