" File: compatibility.vim
" Project: scyn-conf/vim
" Brief: Vim compatibility configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Options:{{{
"------------------------------------------------------------------------------
" Disable Vi-compatibility
set nocompatible
" Load Pathogen
runtime! autoload/pathogen.vim
silent! call pathogen#runtime_append_all_bundles()
" Necessary for arrows and some other keys to work
set term=builtin_ansi
" Enable plugin and indent filetypes
filetype plugin on
filetype indent on
" Allow backspace over everything in insert mode
set backspace=2
" In the case we are using evim, do not load configuration
if v:progname =~? "evim"
    finish
endif
" If we are using VMS version of vim, do not create back-ups
if has("vms")
    set nobackup
else
    set backup
endif


"}}}
