" Tiger.vim
" Brief: Useful tools for Tiger project (fixme)
" Version: 0.1
" Date: 10/04/09
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"


function! <SID>Fixtags()
  " Store indentation
  let l:oldcinoptions = &cinoptions
  " Set new indentation
  let &cinoptions=g:DoxygenToolkit_cinoptions

  " Get fix's author's name
  let g:Name = input("Enter name of the author (generally yours...) : ")
  " Get fix's version
  let g:Version = input("Enter the version to fix : ")

  " insert FIX tags
  mark d
  exec "normal i//FIXBEGIN_TC" . g:Version . " <" . g:Name . ">" . "\n" . "FIXEND_TC" . g:Version . " <" . g:Name . ">"
  exec "normal `d"

  " Restore indentation
  let &cinoptions = l:oldcinoptions
endfunction

command! -nargs=0 Tigerfix :call <SID>Fixtags()


