" File: c.vim
" Brief: Additionnal syntax definitions for EPITA Coding Style
" Version: 
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"
" vim600: set foldmethod=marker:

" {{{ Syntax definitions
"
"	{{{ General
"
syn match	eCS_80columns		".\{80,}"

"	}}}
"	{{{ Functions and calls
"
" Comments handling in function still not functionnal or very slow
"syn region	eCS_function		start=+^{$+ end=+^}$+ contains=eCS_max_blank_lines,eCS_25lines display contained transparent
"syn match	eCS_25lines		"{\(\n.\+\n\?\)\{26,}}" " So basic it's almost useless
"syn match	eCS_25lines		"^{\(\s*\(/\*\_.\{-}\*/\)\?\n\?[^/].\+\n\)\{-26,}\_^}\n"	" Advanced but can freeze vim :/
"syn match	eCS_25lines		"\(\s*\(/\*\_.\{-}\*/\)\?\n\?[^/].\+\n\)\{-25,}"		" Advanced but can freeze vim :/ (use for regions)
"syn match	eCS_max_blank_lines	".*\n\n\n.*"				" use for regions
"syn match	eCS_max_blank_lines	"{\_.*\n\n\n\_.*}"			" use as is

" Calls
syn match	eCS_commas		" ,\|,[^ ]"
syn match	eCS_spaces_paren	"( \| )"

"	}}}
"	{{{ Binary / Unary operators
"
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
