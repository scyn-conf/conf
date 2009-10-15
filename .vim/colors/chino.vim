" Vim color file
" Maintainer:	SnP^ <snp@orc-idea.com>
" Last Change:	2005 Nov 25
	
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "snp"

hi Normal	ctermfg=white	ctermbg=Black   guifg=white	guibg=Black
"hi Normal	ctermfg=7		cterm=bold

hi ErrorMsg	ctermfg=White		ctermbg=Red	guifg=White	guibg=Red
hi Visual	ctermfg=LightBlue	ctermbg=Gray	guifg=LightBlue guibg=Gray
hi VisualNOS	ctermfg=LightBlue	ctermbg=Gray	cterm=reverse,underline

hi Search	ctermfg=DarkBlue  	ctermbg=Gray
hi IncSearch	ctermfg=DarkBlue	ctermbg=Gray

hi SpecialKey	ctermfg=DarkBlue
hi Directory	ctermfg=Cyan
hi Title	ctermfg=Magenta		cterm=bold
hi WarningMsg	ctermfg=Red
hi WildMenu	ctermfg=Yellow		ctermbg=Black	cterm=none
hi ModeMsg	ctermfg=DarkGray
hi MoreMsg	ctermfg=Gray
hi Question	ctermfg=White		cterm=none
hi NonText	ctermfg=DarkBlue

" TODO
hi StatusLine	guifg=blue guibg=darkgray gui=none		ctermfg=blue ctermbg=gray term=none cterm=none
hi StatusLineNC	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none
hi VertSplit	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none

hi Folded	ctermfg=66	ctermbg=Black	cterm=bold
hi FoldColumn	ctermfg=Cyan	ctermbg=Black	cterm=none
hi LineNr	ctermfg=Blue	cterm=bold

hi DiffAdd	guibg=darkblue	ctermbg=darkblue term=none cterm=none
hi DiffChange	guibg=darkmagenta ctermbg=magenta cterm=none
hi DiffDelete	ctermfg=blue ctermbg=cyan gui=bold guifg=Blue guibg=DarkCyan
hi DiffText	cterm=bold ctermbg=red gui=bold guibg=Red

hi Cursor	guifg=#000020 guibg=#ffaf38 ctermfg=bg ctermbg=brown
hi lCursor	guifg=#ffffff guibg=#000000 ctermfg=bg ctermbg=darkgreen

"
" Syntax highlighting
"
  " Comments
hi Comment	ctermfg=43		cterm=bold
  " Class
hi Class	ctermfg=4		cterm=bold
  " Constants
hi Constant	ctermfg=70		cterm=none
  " Identifiers
hi Identifier	ctermfg=LightCyan	cterm=none
hi Function	ctermfg=1		cterm=bold
  " Statements (keywords)
hi Statement	ctermfg=76		cterm=bold
  " Pre-processing options
hi PreProc	ctermfg=5		cterm=bold
  " Types
hi Type		ctermfg=44		cterm=bold
  " Special
hi Special	ctermfg=Magenta		cterm=none
  " Others
hi Error	ctermfg=255		ctermbg=64
hi Ignore	ctermfg=bg
hi Todo		ctermfg=255		ctermbg=64
hi Done		ctermfg=255		ctermbg=44
hi Underlined	cterm=underline

