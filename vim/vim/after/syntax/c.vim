" File: c.vim
" Brief: Additionnal syntax definitions for EPITA Coding Style
" Version: 
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
" vim600: set foldmethod=marker:

" {{{ Guard
if !exists('g:epita_coding_style')
	finish
endif
" }}}
" {{{ Syntax definitions
"
"	{{{ General
syn match	eCS_80columns		".\{80,}"
syn match	eCS_brackets		"[\[\]] \| [\[\]]"

"	}}}
"	{{{ Functions and calls
syn region	eCS_function		start=+^{$+ end=+^}$+ contains=eCS_max_blank_lines,eCS_25lines display contained transparent
" match functions which length excedes 25 lines. A single empty line does not count as a line.
syn match	eCS_25lines		"{\(\n.\+\n\?\)\{26,}}"
" match multiple contiguous empty lines
syn match	eCS_max_blank_lines	".*\n\n\n.*"				" use for regions
" FIXME: advanced matching of 25+ lines functions, handling comments
" It is far too slow to be usable for now.
"syn match	eCS_25lines		"\(\s*\(/\*\_.\{-}\*/\)\?\n\?[^/].\+\n\)\{-25,}" 

" Calls
syn match	eCS_commas		" ,\|,[^ ]"
syn match	eCS_spaces_paren	"( \| )"

"	}}}
"	{{{ Binary / Unary operators
" &&, ||, <<, >>, <=, >=, +=, -=, *=, /=, ==, !=, %=, &=, |=, ^=, <<=, >>=
syn match	eCS_operators		"[^ ]&&\|&&[^ ]"
syn match	eCS_operators		"[^ ]||\|||[^ ]"
syn match	eCS_operators		"[^ ]<<=\?\|<<=\?[^ ]"
syn match	eCS_operators		"[^ ]>>=\?\|>>=\?[^ ]"
syn match	eCS_operators		"[^ ][<>+-\*/=!%&|^]=\|[<>+-\*/=!%&|^]=[^ ]"
" +, ++ 
syn match	eCS_operators		"[a-zA-Z0-9_]+[^+]"
syn match	eCS_operators		"[^+]+[a-zA-Z0-9_]"
syn match	eCS_operators		"[^( \t]++[^ );]"
syn match	eCS_operators		" ++[^a-zA-Z0-9_]"
syn match	eCS_operators		"[^a-zA-Z0-9_]++ "
syn match	eCS_operators		"[^-+=/\*%<>&] ++[a-zA-Z0-9_(]"
" -, --, ->
syn match	eCS_operators		"[a-zA-Z0-9_]-[^->]"
syn match	eCS_operators		"[^- (]-[a-zA-Z0-9_(]"
syn match	eCS_operators		"[^( \t]--[^ );]"
syn match	eCS_operators		" --[^a-zA-Z0-9_]"
syn match	eCS_operators		"[^-+=/\*%<>&] --[a-zA-Z0-9_(]"
syn match	eCS_operators		"[^a-zA-Z0-9_]-- "
syn match	eCS_operators		"[^-+=/\*%<>&|^] -[a-zA-Z0-9_(]"
" *
syn match	eCS_operators		"[^ /]\*[^=a-zA-Z0-9_(/]" " binary operator *, comments and pointers dereferencement
syn match	eCS_operators		"\([^-+=/\*%<>&|^] \|[^ ]\)\*[a-zA-Z0-9_(/]" " pointers dereferencement
" /
syn match	eCS_operators		"[^ \t*]/\|/[^= *]" " binary operator / and comments
" &
syn match	eCS_operators		"[^ ]&[^&=a-zA-Z0-9_( ]" " binary &, logical & and address access
syn match	eCS_operators		"\([^-+=/\*%<>&|^] \|[^ ]\)&[a-zA-Z0-9_(]" " address access
" !(), !=
syn match	eCS_operators		"[^ (]![^a-zA-Z0-9_(=]\|! \|[a-zA-Z0-9_)] ![^=]"
" ~
syn match	eCS_operators		"[^ ]\~\|\~[^a-zA-Z_ (]"
" ^
syn match	eCS_operators		"[^ ]^=\?\|\^[^= ]\|\^=[^ ]"
" %
syn match	eCS_operators		"[^ ]%=\?\|%=[^ ]\|%[^ =]"
" |, ||
syn match	eCS_operators		"[^ ]|[^|=]\|[^|]|[^ =]"
" <, >
syn match	eCS_operators		"[^ <]<\|<[^ <]"
syn match	eCS_operators		"[^ >-]>\|[^-]>[^> =]\|->[^(a-zA-Z0-9_]\| ->"

"	}}}

" }}}
" {{{ Colors links
hi def link	eCS_commas		Error
hi def link	eCS_space_after_kw	Error
hi def link	eCS_operators		Error
hi def link	eCS_spaces_paren	Error
hi def link	eCS_80columns		Error
hi def link	eCS_25lines		Error
hi def link	eCS_max_blank_lines	Error
hi def link	test_comments		Error
"hi def link	eCS_function		Error

" }}}
