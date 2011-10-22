syntax case ignore

syntax match txtComment "#[^0-9].*$"
syntax match txtNumber "#[0-9]\{1,5}"
syntax region txtSection start=+^[ \t]*=+ end=+=$+ keepend
syntax region txtSubSection start=+^[ \t]*>+ end=+$+ keepend
syntax match txtArray "||"
syntax match txtOK "OK"
syntax match txtKO "KO"
syntax match txtDone "\[-\].*$" contains=txtTagDoc
syntax match txtTodo "\[+\]"
syntax match txtImportant "\[!\]"
syntax match txtUnderline ""
syntax match txtReported "\[r\]"
syntax match txtCurrent  "\[%\]"
syntax match txtTagDoc "\[doc\]"


syntax region txtShell start=+^\$+ end=+$+ contains=txtComment

hi def link txtSection 		Type
hi def link txtOK 		String
hi def link txtSubSection   Keyword
hi def link txtKO 		cppcerrcolor
hi def link txtNumber 	Number

hi def link txtDone 			Comment
hi def link txtComment 			Comment
hi def link txtTodo 			String
hi def link txtImportant 		cppcerrcolor
hi def link txtReported 	 	Special
hi def link txtCurrent 			Statement
hi def link txtArray 			Statement

hi def link txtTagDoc 			Function

hi def link txtShell 			Function

let b:current_syntax = "txt"
