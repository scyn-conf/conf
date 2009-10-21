" chcmdmod.vim: useful mappings to switch the current command mode between
"   ':', '/' and '?'.
" Author: Hari Krishna <hari_vim@yahoo.com>
" Last Change: 08-May-2006 @ 14:51
" Requires: Vim-7.0 or higher
" Version: 2.0.2
" Download From:
"     http://www.vim.org/scripts/script.php?script_id=144
" Environment:
"   Adds
"       ^X/, ^X?, ^X:, ^Xw, ^XW, <S-Left>, <S-Right>, ^S
"     command mode mappings.
" Usage:
"   - When you are in one of the :, / or ? modes, switch to a different mode
"     by typing ^X/ or ^X: or ^X?.
"   - While searching you can press ^S to find the next hit, without needing to
"     first press <Enter> followed by n or N. You need to have 'incsearch'
"     option turned on for this to work. You can mix this with the ^X/ and ^X?
"     to reverse the search without needing to press enter and start over.
"   - While searching using 'incsearch', you can use ^Xw to complete the
"     current word (or ^XW for WORD), <S-Right> to fetch one extra character
"     from the end of current match position (or <S-Left> from the beginning).
" NOTE: Observe the use of :<C-R>=Func()<CR><BS> instead of :call Func()<CR>
"   to avoid the call showing up (and the hit return prompt thereafter).
" TODO:
"     - Watchout for CommandEnter and CommandLeave autocommands. The
"	CommandLeave autocommand will be useful to reset the monitoring
"	instead of mapping commands.
"

if exists("loaded_chcmdmod")
  finish
endif
if v:version < 700
  echomsg "chcmdmod: You need Vim 7.0 or higher"
  finish
endif
let loaded_chcmdmod = 200

" Make sure line-continuations won't cause any problem. This will be restored
"   at the end
let s:save_cpo = &cpo
set cpo&vim


if (! exists("no_plugin_maps") || ! no_plugin_maps) &&
      \ (! exists("no_chcmdmod_maps") || ! no_chcmdmod_maps)
inoremap <Plug>CCM: <C-O>:
inoremap <Plug>CCM/ <C-O>/
inoremap <Plug>CCM? <C-O>?
nnoremap <Plug>CCM: :
nnoremap <Plug>CCM/ /
nnoremap <Plug>CCM? ?
cnoremap <Plug>CCMBS <BS>
" Maplets to avoid creating global functions.
"cnoremap <Plug>CCMPre <C-R>=<SID>SaveCmdState()<CR><C-C>
cnoremap <Plug>CCMPre <C-R>=<SID>SaveCmdState()<CR><End><C-U><BS>
cnoremap <Plug>CCMPost <C-R>=<SID>GetLine()<CR><C-R>=<SID>RestPos()<CR>
" The AdvanceLine() works only when called from the : mode.
cnoremap <Plug>CCMSrchPre1 <End><C-U><BS>
cnoremap <Plug>CCMSrchPre2 <C-R>=<SID>AdvanceLine()<CR><BS>
cmap <Plug>CCMSearchPre <Plug>CCMSrchPre1<Plug>CCM:<Plug>CCMSrchPre2
"cnoremap <Plug>CCMSearchPre <End><C-U><BS>:<C-R>=<SID>AdvanceLine()<CR><BS>
"cnoremap <expr> <Plug>CCMSearchPre <SID>AdvanceLine()
nnoremap <Plug>CCMResetLine :<C-R>=<SID>ResetPosition()<CR><BS>
nnoremap <Plug>CCMEndMon :<C-R>=<SID>CCMEnMon()<CR><BS>
cmap <C-X>: <Plug>CCMPre<Plug>CCM:<Plug>CCMPost
cmap <C-X>/ <Plug>CCMPre<Plug>CCM/<Plug>CCMPost
cmap <C-X>? <Plug>CCMPre<Plug>CCM?<Plug>CCMPost
cmap <expr> <C-S> <SID>SearchCommand()
inoremap <Plug>CCMInsEsc <C-O>
nnoremap <Plug>CCMInsEsc <Nop>

cnoremap <expr> <C-X>w <SID>SearchComplete('w')
cnoremap <expr> <C-X>W <SID>SearchComplete('W')
cnoremap <expr> <S-Right> <SID>SearchComplete('f')
cnoremap <expr> <S-Left> <SID>SearchComplete('b')
endif

let s:cmdLine = ""
let s:cmdPos = 0
let s:cmdMode = ""

" Initialize script variables.
let s:CCMoriginalLineNo = 0
let s:monitoring = 0

function! s:SaveCmdState()
  let s:cmdLine = getcmdline()
  let s:cmdPos = getcmdpos()
  let s:cmdMode = getcmdtype()
  return ""
endfunction

function! s:GetLine()
  return s:cmdLine
endfunction

function! s:RestPos()
  call setcmdpos(s:cmdPos)
  return ""
endfunction

function! s:SearchComplete(cmd)
  if getcmdtype() != '/' && getcmdtype() != '?'
    return "\<C-X>".a:cmd
  endif
  " TODO: Restore cursor position.
  let cmd = "\<End>\<C-U>"
  let cmdLine = getcmdline()
  let newcmdpos = getcmdpos()
  if a:cmd == 'w'
    let cmd = cmd.expand('<cword>')
  elseif a:cmd == 'W'
    let cmd = cmd.'\V'.escape(expand('<cWORD>'), '\')
  elseif a:cmd == 'f'
    let cmd = cmd.cmdLine.getline(line('.'))[col('.')-1]
  elseif a:cmd == 'b'
    let cmd = cmd.getline(line('.'))[col('.')-strlen(cmdLine)-2].cmdLine
    let newcmdpos = newcmdpos + 1
  endif
  if getcmdpos() <= strlen(cmdLine)
    let cmd = cmd."\<C-R>=strpart(setcmdpos(".newcmdpos."), 0, 0)\<CR>"
  endif
  return cmd
endfunction

function! s:SearchCommand()
  if getcmdtype() != "/" && getcmdtype() != "?"
    return "\<C-S>"
  endif
  let w:CCMtransLineNo = line(".")
  call s:SaveCmdState()
  call CCMStMon()
  return "\<Plug>CCMSearchPre\<Plug>CCMInsEsc".getcmdtype()."\<Plug>CCMPost"
endfunction

function! s:AdvanceLine()
  call s:EnableAuto(0)
  try
    if ! exists('w:CCMoriginalLineNo')
      let w:CCMoriginalLineNo = line('.')
    endif
    "  Decho "AdvanceLine: cmdMode = " . getcmdtype()
    if s:cmdMode == "/"
      let lineoffset = 1
      let colpos = 0
    elseif s:cmdMode == "?"
      let lineoffset = -1
      let colpos = "$"
    else
      return ""
    endif

    " Workaround for the below movement triggers CursorMoved even though it is
    " disabled during the execution.
    let s:ignoreCCMEnMon = 1
    keepjumps exec (w:CCMtransLineNo + lineoffset)
    keepjumps exec "normal" colpos
    "redraw
    return ""
  finally
    call s:EnableAuto(0)
  endtry
endfunction

function! EnableAuto(b)
  return s:EnableAuto(a:b)
endfunction

function! s:ResetPosition()
"  Decho "ResetPosition"
  if exists("w:CCMoriginalLineNo")
    exec w:CCMoriginalLineNo
  endif
  silent! unlet w:CCMoriginalLineNo
  silent! unlet w:CCMtransLineNo
  call s:CCMEnMon()
  return ""
endfunction

function! s:CtrlU()
  let cmd = "\<C-U>"
  if (getcmdtype() == "/" || getcmdtype() == "?")
    if !(getcmdpos() > strlen(getcmdline()))
      let cmd = cmd."\<Plug>CCMPre"
    else
      let cmd = cmd."\<Plug>CCMBS"
    endif
    let cmd = cmd."\<Plug>CCMInsEsc\<Plug>CCMResetLine\<Plug>CCMInsEsc".
	  \ getcmdtype()
    " If not everything is being killed
    if !(getcmdpos() > strlen(getcmdline()))
      let cmd = cmd."\<Plug>CCMPost"
    endif
  endif
  return cmd
endfunction

function! s:ResetCmd(cmd)
  let cmd = a:cmd
  if a:cmd == "" || (getcmdtype() == "/" || getcmdtype() == "?")
    " If cpoptions contains 'x', then <Esc> is equivalent to <CR>, so don't
    " reset.
    if (a:cmd != "\<Esc>" || &cpoptions !~ '.*x.*')
      let cmd = cmd."\<Plug>CCMInsEsc\<Plug>CCMResetLine"
    endif
  endif
  return cmd
endfunction

function! s:CRNL(crnl)
  let cmd = a:crnl
  if (getcmdtype() == "/" || getcmdtype() == "?")
    let cmd = cmd."\<Plug>CCMEndMon"
  endif
  return cmd
endfunction

function! CCMStMon()
  if !s:monitoring
    let s:monitoring = 1

    cmap <expr> <buffer> <C-U> <SID>CtrlU()
    cmap <expr> <buffer> <C-C> <SID>ResetCmd("\<C-C>")
    cmap <expr> <buffer> <Esc> <SID>ResetCmd("\<Esc>")
    cmap <expr> <buffer> <CR> <SID>CRNL("\<CR>")
    cmap <expr> <buffer> <NL> <SID>CRNL("\<NL>")

    " This is a trick that works quite nicely. For the last <BS>, the
    "   <Plug>CCMHdlrBS gets executed in the normal or insert mode. For the rest
    "   of the <BS>'s, it is executed in the command mode and is ignored.
    cmap <buffer> <BS> <Plug>CCMBS<Plug>CCMHdlrBS
    "cmap <buffer> <Plug>CCMHdlrBS <Nop> " This doesn't update selection for some reason.
    cnoremap <buffer> <Plug>CCMHdlrBS <Space><BS>
    nmap <expr> <buffer> <Plug>CCMHdlrBS <SID>ResetCmd("")
    imap <expr> <buffer> <Plug>CCMHdlrBS <SID>ResetCmd("")
    call s:EnableAuto(1)
  endif
endfunction

function! s:EnableAuto(enable)
  aug CCMEnMon
    au!
    if a:enable
      au CursorHold * :call <SID>CCMEnMon()
      au CursorMoved * :call <SID>CCMEnMon()
      au CursorMovedI * :call <SID>CCMEnMon()
    endif
  aug END
  return ""
endfunction

let s:ignoreCCMEnMon = 0
function! s:CCMEnMon()
  if s:ignoreCCMEnMon
    let s:ignoreCCMEnMon = 0
    return
  endif
  if s:monitoring
    silent! cunmap <buffer> <C-U>
    silent! cunmap <buffer> <C-C>
    silent! cunmap <buffer> <Esc>
    silent! cunmap <buffer> <CR>
    silent! cunmap <buffer> <C-R>=
    silent! cunmap <buffer> <BS>
    silent! cunmap <buffer> <Plug>CCMHdlrBS
    silent! nunmap <buffer> <Plug>CCMHdlrBS
    silent! iunmap <buffer> <Plug>CCMHdlrBS
    call s:EnableAuto(0)
    let s:monitoring = 0
  endif
  return ""
endfunction

" Restore cpo.
let &cpo = s:save_cpo
unlet s:save_cpo

" vim6:fdm=marker sw=2
