" File: mappings.vim
" Brief: mappings for vim configuration file.
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
" 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFERS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer changing / cycling files through buffer
map <S-LEFT> <ESC>:bp<RETURN>
map <S-RIGHT> <ESC>:bn<RETURN>
map <SPACE>k <C-w><up>
map <SPACE>j <C-w><down>
map <SPACE>l <C-w><right>
map <SPACE>h <C-w><left>
" Tab moving
map :ee :tabe
map <SPACE>- :tabp<RETURN>
map <SPACE>= :tabn<RETURN>
" Resize buffers
map <C-right> <C-W>< 
map <C-left> <C-W>> 
" BufExplorer
nmap <silent> <unique> <SPACE><SPACE> :BufExplorer<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" reindent file
map <F12> ggvG=``
" set indentation behavior
map <F11> :call My_indent_style ()<CR>
" Toogle visual tabs
map <F10> :call SeeTab ()<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
map <F8> :NERDTree `pwd`<RETURN>
" vcscommand
let mapleader = ';'
map <Leader>add :VCSAdd<CR>
map <Leader>up :VCSUpdate<CR>
map <Leader>ci :VCSCommit<CR>
map <Leader>vdiff :tabe %<CR>:VCSVimDiff<CR>
map <Leader>diff :VCSDiff<CR>
map <Leader>log :VCSLog<CR>
map <Leader>st :VCSStatus<CR>
map <Leader>info :VCSInfo<CR>
" FuzzyFinder
nmap <silent> <unique> <SPACE>o :FufBuffer<CR> 
nmap <silent> <unique> <SPACE>f :FufFile<CR>
nmap <silent> <unique> <SPACE>d :FufDir<CR>
nmap <silent> <unique> <SPACE>c :FufChangeList<CR>
nmap <silent> <unique> <SPACE>m :FufBookmark<CR>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delete white trails
map -tw <ESC>:%s/\s\+$//<RETURN>``:noh<RETURN>
" Delete trailing whitespaces when saving
map <F6> -tw:w<RETURN>
" Opening and closing braces
imap {<tab> {<CR>}<C-O>O
" Opening and closing parenthesis
imap ( ()<ESC>i
" Change textwidth values (200 or 80)
map <F9> :call ToogleTextWidth ()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Esc shortcut
imap jj <Esc>
" Unfold all file
map ZO ggvGzO
" disable highlighting : Useful after performing a search
map -- <ESC>:noh<RETURN>
" cpp ctags generation
map :tags :! /Users/scyn/Code/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F7> :tags
" Doxygen plugin fixes
map dox <ESC>:Dox<RETURN><ESC>-tw
" gnull
map :gnull :! gmake > /dev/null
map <F5> :gnull
" Folding functions
map -f <ESC>/^}<RETURN><ESC>zf%
" access to ~/.vimrc
map :rc :e ~/.vimrc
map <F2> :rc<RETURN>
" opens mappings file
map :ma :e ~/.vim/mappings.vim
map <F3> :ma<RETURN>
" opens functions file
map :fun :e ~/.vim/fun.vim
map <F4> :fun<RETURN>
" Open cwd
cmap ewd e .
