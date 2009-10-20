" Vim indent file
" Language:     Tiger
" Maintener:    Florent Thoumie <flz@xbsd.org>
" Version:	0.1
" Last Change:  2006 Mar 11

" This file is for scholastic purposes only.
" My knowledge of vim indent/syntax files is _really_ poor so these two
" files don't do anything else that what _i_ want them to do.

if exists("b:did_tiger_indent")
  finish
endif
let b:did_tiger_indent = 1

setlocal indentkeys+=0=end,0=in,0},0),0(,0{
setlocal indentexpr=GetTigerIndent()
setlocal nolisp
setlocal nosmartindent
setlocal shiftwidth=2
setlocal textwidth=76

if exists("*GetTigerIndent")
  finish
endif

function GetTigerIndent()
  let lnum = prevnonblank(v:lnum - 1)
  
  if lnum == 0
    return 0
  endif

  " Get current indentation, current line and previous line.
  let ind = indent(lnum)
  let line = getline(v:lnum)
  let lline = getline(lnum)
  let llline = getline(lnum - 1)

  " If previous line ends with :
  if lline =~ '\({\|(\|=\|\<\(let\|in\|then\|else\)\>\)\s*$'
    let ind = ind + &sw 
  elseif lline =~ '\<end\>\s*$'
    let ind = ind - &sw

  " If we have several 'if's 
  elseif llline =~ '^\s*\(if\)' && llline =~ 'then\s*$' && lline !~ '^\s*if\>'
    let ind = ind - &sw
    
  endif

  " If current line begins with :
  if line =~ '^\s*\(in\|end\|else\|)\|}\)'
    return ind - &sw

  " If current line bgeins with '(' of '{' and previous line begins
  " with 'function' or 'type'
  elseif line =~ '^\s*\((\|{\)' && lline =~ '^\s*\(function\|type\)\>'
    return ind - &sw
  endif
  
  return ind;
endfunction

" vim:sw=2
