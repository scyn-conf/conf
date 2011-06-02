" File: notes.vim
" Project: scyn-conf/conf/vim
" Brief: syntax definition for NOTES.txt files
" Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
"

syntax case ignore

" {{{ syntax matching
syntax match	notesComment		"#[^-9].*$"
syntax match	notesTagDone		"\[-\]"
syntax match	notesTagTodo		"\[+\]"
syntax match	notesTagCurrent		"\[%\]"
syntax match	notesTagImportant	"\[!\]"
syntax match	notesTagDoc		"\[doc\]"
syntax match	notesUnderline		" _.*_ "
syntax match	notesBold		"\*.*\*"
syntax match	notesItalic		"\~.*\~"
syntax match	notesDebug		"^(gdb) .*$"
syntax match	notesOutputEmphasize	"^!.*$" contained

" }}}
" {{{ syntax region matching
syntax region	notesSection	start=+^=+	end=+=+
syntax region	notesShell	start=+42sh\$+	end=+$+		contains=notesComment
syntax region	notesOutput	start=+<\[+	end=+\]>+	contains=notesBold, notesUnderline, notesItalic, notesTagImportant, notesTagCurrent, notesTagTodo, notesTagDone, notesDebug, notesOutputEmphasize

" }}}
" {{{ color links
hi def link	notesComment		Comment
hi def link	notesTagDone		Comment
hi def link	notesTagTodo		String
hi def link	notesTagCurrent		Statement
hi def link	notesTagImportant	cppcerrcolor
hi def link	notesTagDoc		Function
hi def link	notesSection		Type
hi def link	notesBold		Bold
hi def link	notesUnderline		Underline
hi def link	notesItalic		Italic
hi def link	notesShell		Statement
hi def link	notesDebug		Statement
hi def link	notesOutput		Comment
hi def link	notesOutputEmphasize	cppcerrcolor

let b:current_syntax = "notes"

" }}}

