" File: plugins.vim
" Project: scyn-conf/conf/vim
" Brief: Vim plugins configuration file
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

" Variables:{{{
"------------------------------------------------------------------------------
" OmniCPP
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_SelectFirstItem = 2

" Autofile
let me_name='Scyn - Remi Chaintron'
let me_mail='remi.chaintron@gmail.com'

" SuperTab
let g:SuperTabCrMapping = 0

" Syntastic
let syntastic_enable_signs = 1
let g:syntastic_auto_loc_list=1


"}}}
" Mappings:{{{
"------------------------------------------------------------------------------
" FuzzyFinder
nmap <silent> <unique> <SPACE>o :FufBuffer<CR> 
nmap <silent> <unique> <SPACE>f :FufFile<CR>
nmap <silent> <unique> <SPACE>d :FufDir<CR>
nmap <silent> <unique> <SPACE>cl :FufChangeList<CR>
nmap <silent> <unique> <SPACE>m :FufBookmarkFile<CR>
nmap <silent> <unique> <SPACE>a :FufBookmarkAddFile<CR>
nmap <silent> <unique> <SPACE><TAB> :FufCoverageFile<CR>
nmap <silent> <unique> <SPACE>e :FufMruFile<CR>
nmap <silent> <unique> <SPACE>c :FufMruCmd<CR>

" NERDTree
map <F8> :NERDTree `pwd`<RETURN>




"}}}

