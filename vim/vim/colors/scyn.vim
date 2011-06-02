" File: scyn.vim
" Project: scyn-conf/vim
" Brief: Vim 'scyn' colorscheme
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
let g:colors_name="scyn"


hi Boolean		guifg=#AE81FF
hi Character		guifg=#E6DB74
"hi Number		guifg=#AE81FF
"hi Number		guifg=#FF9800
hi Number		guifg=#f6c84c
"hi String		guifg=#E6DB74
hi String		guifg=#A6E22E
"hi Conditional		guifg=#d02e54			gui=bold
hi Conditional		guifg=#96CBFE			gui=none
hi Constant		guifg=#AE81FF			gui=bold
hi Cursor		guifg=#000000	guibg=#F8F8F0
hi Debug		guifg=#BCA3A3			gui=bold
hi Define		guifg=#66D9EF
hi Delimiter		guifg=#66D9EF
"hi Delimiter		guifg=#8F8F8F
hi DiffAdd				guibg=#13354A
hi DiffChange		guifg=#89807D 	guibg=#4C4745
hi DiffDelete		guifg=#960050 	guibg=#1E0010
hi DiffText				guibg=#4C4745	gui=italic,bold

hi Directory		guifg=#A6E22E			gui=bold
hi Error		guifg=#d02e54 	guibg=#1B1D1E
hi ErrorMsg		guifg=#d02e54 	guibg=#1B1D1E 	gui=italic
hi Exception		guifg=#d02e54			gui=bold
hi Float		guifg=#AE81FF
hi FoldColumn		guifg=#465457 	guibg=#000000
hi Folded		guifg=#465457 	guibg=#000000
hi Function		guifg=#A6E22E
hi Identifier		guifg=#FD971F
hi Ignore		guifg=#808080			guibg=bg
hi IncSearch		guifg=#C4BE89 	guibg=#000000

"hi Keyword		guifg=#d02e54			gui=bold
hi Keyword		guifg=#66D9EF			gui=none
hi Label		guifg=#E6DB74			gui=none
hi Macro		guifg=#C4BE89			gui=italic
hi SpecialKey		guifg=#66D9EF			gui=italic

hi MatchParen		guifg=#000000 	guibg=#FD971F 	gui=bold
hi ModeMsg		guifg=#E6DB74
hi MoreMsg		guifg=#E6DB74
hi Operator		guifg=#d02e54

"hi Pmenu		guifg=#66D9EF 	guibg=#000000
hi Pmenu		guifg=#66D9EF 	guibg=#1B1D1E
"hi PmenuSel				guibg=#808080
hi PmenuSel		guifg=#A6E22E   guibg=#1B1D1E	gui=bold
hi PmenuSbar				guibg=#080808
"hi PmenuThumb		guifg=#66D9EF
hi PmenuThumb		guifg=#202020

hi PreCondit		guifg=#A6E22E			gui=bold
"hi PreProc		guifg=#A6E22E
hi Preproc		guifg=#d02e54			gui=none
hi Question		guifg=#66D9EF
hi Repeat		guifg=#96CBFE			gui=bold
hi Search		guifg=#FFFFFF 	guibg=#455354
" marks column
hi SignColumn		guifg=#A6E22E 	guibg=#232526
"hi SpecialChar		guifg=#d02e54			gui=bold
hi SpecialChar		guifg=#d02e54			gui=bold
hi SpecialComment	guifg=#465457			gui=bold
hi Special		guifg=#66D9EF	guibg=bg	gui=italic
hi SpecialKey		guifg=#888A85			gui=italic
if has("spell")
hi SpellBad		guisp=#FF0000			gui=undercurl
hi SpellCap		guisp=#7070F0			gui=undercurl
hi SpellLocal		guisp=#70F0F0			gui=undercurl
hi SpellRare		guisp=#FFFFFF			gui=undercurl
endif

"hi Statement		guifg=#d02e54			gui=bold
hi Statement		guifg=#96CBFE			gui=none
"hi StatusLine		guifg=#455354			guibg=fg
hi StatusLine		guifg=#69D9EF 	guibg=#1B1D1E	gui=none
hi StatusLineNC		guifg=#293739 	guibg=#1B1D1E	gui=none
hi StorageClass		guifg=#FD971F			gui=italic
hi Structure		guifg=#66D9EF
hi Tag			guifg=#d02e54			gui=italic
hi Title		guifg=#ef5939
hi Todo			guifg=#FFFFFF	guibg=bg	gui=bold

hi Typedef		guifg=#66D9EF
hi Type			guifg=#66D9EF			gui=none
hi Underlined		guifg=#808080			gui=underline

hi VertSplit		guifg=#808080 	guibg=#1B1D1E 	gui=bold
hi VisualNOS				guibg=#403D3D
hi Visual				guibg=#403D3D
hi WarningMsg		guifg=#d02e54 	guibg=#1B1D1E 	gui=italic
hi WildMenu		guifg=#66D9EF 	guibg=#000000
hi Normal		guifg=#F8F8F2 	guibg=#101213
"   hi Comment		guifg=#465457
hi Comment		guifg=#293739
"hi CursorLine				guibg=#293739
hi CursorLine				guibg=#1B1D1E
hi CursorColumn				guibg=#1B1D1E
"hi LineNr		guifg=#BCBCBC 	guibg=#232526
hi LineNr		guifg=#293739 	guibg=#101213
"hi NonText		guifg=#BCBCBC 	guibg=#232526
hi NonText		guifg=#BCBCBC 	guibg=#101213
