" Vim syntax file
" Language:	MIPS assembly for Tiger Compiler
" Maintainer:	Scyn <chaint_r@epita.fr>
" Last Change:	2009 May 15

au! Syntax as source $HOME/.vim/syntax/mips.vim


syn keyword 	mInstr 		add addi addu addiu and andi beq bgez bgt mul bgezal bgtz blez bltz bltzal div divu j jal jr lb lui lw mfhi mflo move li la blt bne lbu mult multu noop nop or ori sb sll sllv slt slti sltiu sltu sra srl srlv subu sw xor xori sub remu
syn keyword 	mSyscall 	syscall
syn match 	mRegisters   	"$[at][0-9]\|$ra\|$v[01]\|$zero"
syn region 	mLabels 	start="^[a-zA-Z]" end=":" keepend
syn keyword 	mFix 		contained FIXME FIXBEGIN_TC7 FIXEND_TC7
syn match 	logins 		display contained "<.*>"
syn match  	mInts  		"-\?[0-9]\+\|0x\([0-8]\+\)"
syn region 	mString 	start="\"" end="\"" keepend
syn region 	mComments 	start="#" end="$" keepend contains=mFix,logins

hi def link mInstr 	Include
hi def link mSyscall 	Todo
hi def link mRegisters  Identifier
hi def link mComments 	Comment
hi def link mLabels 	Type
hi def link mInts 	String
hi def link mString 	String
hi def link mFix 	Fix
hi def link logins 	Identifier

let b:current_syntax = "mips"

" vim: ts=8
