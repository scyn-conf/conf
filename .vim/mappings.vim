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
nmap <silent> <unique> <SPACE>o :BufExplorer<CR>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
map nt :NERDTree `pwd`<RETURN>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delete white trails
map -tw <ESC>:1,$s/[<tab> ]*$//<RETURN>`'<ESC>:noh<RETURN>
" Delete trailing whitespaces when saving
map :dw -tw:w<RETURN>
" reindent file
map == ggvG=''
" create one line of = symbols under the cursor
map =line o=========================================================================<ESC>0
" Opening and closing braces
imap {<tab> {<CR>}<C-O>O
" Opening and closing parenthesis
imap ( ()<ESC>i
" Opening and closing brackets
"imap [ []<ESC>i
" Opening and closing quotes
"imap ' '<ESC>vypi
"Opening and closing double-quotes
"imap " "<ESC>vypi
 " Struct / Enum / Union
imap struct<tab>	struct <RETURN>{<tab><ESC>jA<tab><tab><tab><tab><tab>;<ESC>i
imap enum<tab>	enum<RETURN>{<tab><ESC>jA<tab><tab><tab>;<ESC>i
imap union<tab>	union<RETURN>{<tab><ESC>jA<tab><tab><tab>;<ESC>i
imap class<tab> class<RETURN>{<tab>public:<RETURN><RETURN>private:<RETURN><ESC>jA;<ESC>h%kA 
" expand typedef struct/enum/union
map -et <ESC>$hvby<ESC>0%kitypedef <ESC>A<tab><tab><ESC>pjji<tab>
"expand struct/enum/union
map -en <ESC>$hvbd<ESC>0%kA<tab><tab><ESC>pj0%ddi<RETURN>};<ESC>ki<tab>
" main function
"imap main<tab> int <tab><tab>main (int <tab><tab>argc,<RETURN><tab><tab>  char** <tab><tab>argv<ESC>A<RETURN>{<tab>
" redefine <tab> behavior for completion
inoremap <Tab> <C-R>=MayComplete()<RETURN>



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
" Doxygen plugin fixes
map dox <ESC>:Dox<RETURN><ESC>-tw
" gnull
map :gnull :! gmake > /dev/null
" Folding functions
map -f <ESC>/^}<RETURN><ESC>zf%
" access to ~/.vimrc
map :rc :e ~/.vimrc
" opens mappings file
map :ma :e ~/.vim/mappings.vim
" opens functions file
map :fun :e ~/.vim/fun.vim
" set indentation behavior
map <F11> :call My_indent_style ()<CR>
" Toogle visual tabs
map <F12> :call SeeTab ()<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C / CPP SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" std::cout/cerr mapping
imap cout<tab> std::cout <<  << std::endl;<ESC>13hi
imap cerr<tab> std::cerr <<  << std::endl;<ESC>13hi
" For loop
"imap for<tab> for (;;<ESC>A<RETURN>{<tab><ESC>kk$%a
"" While loop
"imap while<tab> while (<ESC>A<RETURN>{<tab><ESC>kk$%a



