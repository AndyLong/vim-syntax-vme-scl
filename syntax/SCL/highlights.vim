" VIM Syntax File
" Language:	ICL/Fujitsu VME SCL programs
" Maintainer:	Andy Long (AndrewGLong@Yahoo.com)
" LastChange:	April 2004
" Remarks:	VME SCL is the System Control Language (JCL, to IBM-heads)
" 		for the (formerly) ICL (now) Fujitsu mainframe VME systems.
"
"	$Log: reservedWords.vim,v $
"	Revision 1.1.2.3  2011-03-17 08:15:07  0126792
"	Fix problems with folding of assignments containing Comments.
"	TODO: doesn't handle embedded blank lines correctly.
"
"	Fix problems with syntax highlighting of relational operators.
"	TODO: Built-in procedures highlighting.
"
"	Fix highlighting for Pragmas.
"
" if exists("b:current_syntax")
" 	finish
" endif

if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink	sclIdentifier	Identifier

	HiLink	sclNumber	Number
	HiLink	sclHexNumber	Number

	HiLink	sclComment	Comment

	HiLink	sclConstant	Constant
	HiLink	sclNil		Constant
	HiLink	sclTrue		Constant
	HiLink	sclFalse	Constant
	HiLink	sclAlienData	Constant
	HiLink	sclLabel	Constant

	HiLink	sclStringConst	String

	HiLink	sclType		Type
	HiLink	sclProc		Type
	HiLink	sclMacro	Type
	HiLink	sclInt		Type
	HiLink	sclBool		Type
	HiLink	sclString	Type
	HiLink	sclSString	Type
	HiLink	sclLiteral	Type
	HiLink	sclSLiteral	Type
	HiLink	sclResponse	Type

	HiLink	sclStorageClass	StorageClass
	HiLink	sclExt		StorageClass
	HiLink	sclRef		StorageClass

	HiLink	sclBoolean	Boolean

	HiLink	sclBoolOp	Operator
	HiLink	sclAnd		Operator
	HiLink	sclOr		Operator
	HiLink	sclNeq		Operator

	HiLink	sclUnaryBoolOp	Operator
	HiLink	sclNot		Operator

	HiLink	sclAssignOp	Operator
	HiLink	sclIs		Operator

	HiLink	sclArithOp	Operator
	HiLink	sclPlus		Operator
	HiLink	sclMinus	Operator
	HiLink	sclMultiply	Operator
	HiLink	sclDivide	Operator

	HiLink	sclUnaryArithOp	Operator
	HiLink	sclCount	Operator
	HiLink	sclBound	Operator
	HiLink	sclLength	Operator

	HiLink	sclStringOp	Operator
	HiLink	sclAfter	Operator
	HiLink	sclBefore	Operator
	HiLink	sclVal		Operator

	HiLink	sclSStringOp	Operator
	HiLink	sclAmpersand	Operator

	HiLink	sclRelOp	Operator
	HiLink	sclEndswith	Operator
	HiLink	sclStartswith	Operator
	HiLink	sclIncludes	Operator
	HiLink	sclEq		Operator
	HiLink	sclNe		Operator
	HiLink	sclLt		Operator
	HiLink	sclLe		Operator
	HiLink	sclGt		Operator
	HiLink	sclGe		Operator

	HiLink	sclFunction	Operator
	HiLink	sclBin		Operator
	HiLink	sclChartoint	Operator
	HiLink	sclClock	Operator
	HiLink	sclDigits	Operator
	HiLink	sclFill		Operator
	HiLink	sclFind		Operator
	HiLink	sclHex		Operator
	HiLink	sclhextochar	Operator
	HiLink	sclIndex	Operator
	HiLink	sclNumeric	Operator
	HiLink	sclStatus	Operator
	HiLink	sclStint	Operator
	HiLink	sclSubstr	Operator

	HiLink	sclProcBegin	Statement
	HiLink	sclMacBegin	Statement
	HiLink	sclProcEnd	Statement
	HiLink	sclMacEnd	Statement
	HiLink	sclBegin	Statement
	HiLink	sclEnd		Statement
	HiLink	sclGoto		Statement
	HiLink	sclEnter	Statement
	HiLink	sclSyscall	Statement
	HiLink	sclReturn	Statement

	HiLink	sclFor		Repeat
	HiLink	sclFrom		Repeat
	HiLink	sclBy		Repeat
	HiLink	sclTo		Repeat
	HiLink	sclWhile	Repeat
	HiLink	sclUntil	Repeat
	HiLink	sclDo		Repeat
	HiLink	sclRepeat	Repeat

	HiLink	sclIf		Conditional
	HiLink	sclUnless	Conditional
	HiLink	sclThen		Conditional
	HiLink	sclElsf		Conditional
	HiLink	sclElse		Conditional
	HiLink	sclFi		Conditional

	HiLink	sclWhenever	Exception

	HiLink	sclSpecial	Special
	HiLink	sclReschedule	Special
	HiLink	sclNoReschedule	Special
	HiLink	sclSpecialChar	SpecialChar
	HiLink	sclStringEsc1	Special
	HiLink	sclStringEsc2	Special
	HiLink	sclTag		Tag

	HiLink	sclDelimiter	Delimiter
	HiLink	sclComma	Delimiter
	HiLink	sclSemiColon	Delimiter
	HiLink	sclColon	Delimiter
	HiLink	sclParens	Delimiter

	HiLink	sclSpecialComment	SpecialComment
	HiLink	sclDebug	Debug

	HiLink	sclUnderlined	Underlined

	HiLink	sclIgnore	Ignore

	HiLink	sclError	Error

	HiLink	sclTodo		Todo

	delcommand HiLink
endif
