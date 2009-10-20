syntax case ignore
syntax match Title   /^\*.*$/
syntax match Comment /^[ ]\+[a-z0-9].*/
syntax match Statement /^[ ]\+-.*/
syntax match Question /^[ ]\+\/.*/


let b:current_syntax = "wtodo"
