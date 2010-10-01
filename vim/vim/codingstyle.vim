" File: codingstyle.vim
" Brief: global variables toogling coding styles
" Version: 0.1
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
" {{{	EPITA Coding Style
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable additionnal syntax definitions (EPITA Coding Style compliance).
" Comment variables definitions to disable
let g:eCS_enabled=1 
if exists('g:eCS_enabled')
	let g:eCS_80columns=1
	let g:eCS_functions=1
	let g:eCS_operators=1
	let g:eCS_misc=1
endif
