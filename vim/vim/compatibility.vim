" File: compatibility.vim
" Project: scyn-conf/vim
" Brief: Vim compatibility configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


" Preload:{{{
"------------------------------------------------------------------------------
" Load Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"}}}
" Options:{{{
"------------------------------------------------------------------------------
" Disable Vi-compatibility
set nocompatible
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
