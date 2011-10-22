" File: spring.vim
" Project: scyn-conf/vim
" Brief: Vim 'spring' colorscheme
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

hi clear

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif
let g:colors_name="spring"

" Syntax highlighting
hi Normal		guifg=#f8f8f2 	guibg=#191b1c
hi Comment		guifg=#424242			ctermfg=darkmagenta				gui=italic
hi Number		guifg=#f4af60			ctermfg=darkyellow				gui=NONE
hi String		guifg=#a6e22e			ctermfg=lightgreen				gui=italic
hi Constant		guifg=#948771			ctermfg=darkcyan
hi Statement		guifg=#00bfff			ctermfg=blue					gui=none
hi Keyword		guifg=#66d9ef			ctermfg=blue					gui=none
hi Conditional		guifg=#00bfff			ctermfg=blue					gui=none
hi Repeat		guifg=#00bfff			ctermfg=blue					gui=none
"hi Identifier		guifg=#a6e22e			ctermfg=lightgreen
hi Identifier		guifg=#00bfff			ctermfg=lightblue
hi Operator		guifg=#ff7f50			ctermfg=lightred
hi Function		guifg=#f6c84c			ctermfg=yellow

hi Preproc		guifg=#ff6347			ctermfg=lightred				gui=none
hi Macro		guifg=#948771			ctermfg=darkcyan
hi Define		guifg=#66d9ef			ctermfg=darkcyan

hi Label		guifg=#e6db74									gui=none
hi Exception		guifg=#ff6347			ctermfg=lightred				gui=none

hi Structure		guifg=#00bfff			ctermfg=blue					gui=none
hi Typedef		guifg=#4682b4			ctermfg=blue
hi Type			guifg=#1e90ff			ctermfg=darkblue				gui=none
hi StorageClass		guifg=#948771			ctermfg=darkcyan

hi SpecialChar		guifg=#ff6347			ctermfg=lightred				gui=none
hi SpecialKey		guifg=#66d9ef									gui=italic
hi Special		guifg=#a9a9a9	guibg=bg	ctermfg=lightred				gui=italic
hi SpecialComment	guifg=#424242			ctermfg=darkmagenta				gui=bold,italic

hi Delimiter		guifg=#66d9ef
hi MatchParen		guifg=#000000 	guibg=#00bfff 	ctermfg=lightred	ctermbg=none		gui=bold

hi Debug		guifg=#bca3a3			ctermfg=red					gui=bold
hi Todo			guifg=#ffffff	guibg=bg	ctermfg=red					gui=bold
hi Error		guifg=#d02e54 	guibg=#1b1d1e	ctermfg=darkred		ctermbg=none
hi ErrorMsg		guifg=#d02e54 	guibg=#1b1d1e 	ctermfg=darkred		ctermbg=none		gui=italic

" Spell
if has("spell")
	hi SpellBad	guifg=#d02e54									gui=italic
	hi SpellCap	guisp=#7070f0									gui=undercurl
	hi SpellLocal	guisp=#70f0f0									gui=undercurl
	hi SpellRare	guisp=#ffffff									gui=undercurl
endif


" Diff colors
hi DiffAdd				guibg=#13354a
hi DiffChange		guifg=#89807d 	guibg=#4c4745
hi DiffDelete		guifg=#960050 	guibg=#1e0010
hi DiffText				guibg=#4c4745							gui=italic,bold

" Editor
hi Cursor		guifg=#000000	guibg=#f8f8f0
hi StatusLine		guifg=#00bfff 	guibg=#1b1d1e	ctermfg=darkmagenta	ctermbg=lightblue	gui=none
hi StatusLineNC		guifg=#424242 	guibg=#1b1d1e	ctermfg=darkgray	ctermbg=darkmagenta	gui=none
hi CursorLine				guibg=#181a1b				ctermbg=darkgray
hi CursorColumn				guibg=#1b1d1e				ctermbg=darkgray
hi LineNr		guifg=#424242 	guibg=#191b1c	ctermfg=darkmagenta
hi NonText		guifg=#bcbcbc 	guibg=#191b1c	ctermfg=darkgray	ctermbg=darkgray
hi VertSplit		guifg=#1b1d1e 	guibg=#1b1d1e	ctermfg=darkgray	ctermbg=darkmagenta
hi VisualNOS				guibg=#403d3d
hi Visual				guibg=#403d3d				ctermbg=darkmagenta
hi WarningMsg		guifg=#d02e54 	guibg=#1b1d1e							gui=italic

" Misc
hi Directory		guifg=#a6e22e									gui=italic

" Folds
hi FoldColumn		guifg=#00bfff 	guibg=#191b1c	ctermfg=blue
hi Folded		guifg=#00bfff 	guibg=#191b1c	ctermfg=blue

" Search
hi Ignore		guifg=#808080									guibg=bg
hi IncSearch		guifg=#c4be89 	guibg=#000000

" Menu
hi Pmenu		guifg=#00bfff 	guibg=#1b1d1e	ctermfg=blue		ctermbg=darkgray
hi PmenuSel		guifg=#a6e22e   guibg=#1b1d1e	ctermfg=lightgreen				gui=none
hi PmenuSbar				guibg=#080808
hi PmenuThumb		guifg=#00bfff			ctermfg=blue
hi WildMenu		guifg=#00bfff 	guibg=#000000
