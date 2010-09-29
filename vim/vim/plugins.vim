" File: plugins.vim
" Brief: Vim plugins configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OMNICOMPLETION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cpp
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_SelectFirstItem = 2



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VCSCOMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let VCSCommandGitExec = '/usr/bin/git'
let VCSCommandSVNExec = '/usr/bin/svn'
let VCSCommandSplit = 'vertical'
set statusline=%<%f\ %{VCSCommandGetStatusLine()}\ %h%m%r%=%l,%c%V\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOFILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let me_name='Scyn - Remi Chaintron'
let me_mail='remi.chaintron@gmail.com'
