" Vim syntax file
" Language:	Sparc ASM
" Maintainer:	Scyn <chaint_r@epita.fr>
" Last Change:	2008 November 21

au! Syntax as source $HOME/.vim/syntax/as.vim


syn keyword aSection	.section .ends .proc .endp

hi def link aSection	Include

let b:current_syntax = "as"

" vim: ts=8
