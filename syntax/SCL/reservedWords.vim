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
"
" if exists("b:current_syntax")
" 	finish
" endif

syntax	match	sclTrue	contained
	\	/\<true\>/
syntax	match	sclFalse	contained
	\	/\<false\>/
syntax	match	sclNil	contained
	\	/\<nil\>/
syntax	match	sclBool	contained
	\	/\<bool\>/
syntax	match	sclInt	contained
	\	/\<int\>/
syntax	match	sclLiteral	contained
	\	/\<literal\>/
syntax	match	sclMacro	contained
	\	/\<macro\>/
syntax	match	sclProc	contained
	\	/\<proc\>/
syntax	match	sclResponse	contained
	\	/\<response\>/
syntax	match	sclString	contained
	\	/\<string\>/
syntax	match	sclSliteral	contained
	\	/\<superliteral\>/
syntax	match	sclSString	contained
	\	/\<superstring\>/
syntax	match	sclExt	contained
	\	/\<ext\>/
syntax	match	sclRef	contained
	\	/\<ref\>/
syntax	match	sclNoReschedule	contained
	\	/\<noreschedule\>/
syntax	match	sclReschedule	contained
	\	/\<reschedule\>/
syntax	match	sclEnter	contained
	\	/\<enter\>/
syntax	match	sclGoto	contained
	\	/\<goto\>/
syntax	match	sclReturn	contained
	\	/\<return\>/
syntax	match	sclSyscall	contained
	\	/\<syscall\>/
syntax	match	sclMacBegin	contained
	\	/\<macbegin\>/
syntax	match	sclMacEnd	contained
	\	/\<macend\>/
syntax	match	sclProcBegin	contained
	\	/\<procbegin\>/
syntax	match	sclProcEnd	contained
	\	/\<procend\>/
syntax	match	sclBegin	contained
	\	/\<begin\>/
syntax	match	sclEnd	contained
	\	/\<end\>/
syntax	match	sclWhenever	contained
	\	/\<whenever\>/
syntax	match	sclIf	contained
	\	/\<if\>/
syntax	match	sclUnless	contained
	\	/\<unless\>/
syntax	match	sclThen	contained
	\	/\<then\>/
syntax	match	sclElsf	contained
	\	/\<elsf\>/
syntax	match	sclElse	contained
	\	/\<else\>/
syntax	match	sclFi	contained
	\	/\<fi\>/
syntax	match	sclFor	contained
	\	/\<for\>/
syntax	match	sclFrom	contained
	\	/\<from\>/
syntax	match	sclBy	contained
	\	/\<by\>/
syntax	match	sclTo	contained
	\	/\<to\>/
syntax	match	sclWhile	contained
	\	/\<while\>/
syntax	match	sclUntil	contained
	\	/\<until\>/
syntax	match	sclDo	contained
	\	/\<do\>/
syntax	match	sclRepeat	contained
	\	/\<repeat\>/
syntax	match	sclBin	contained
	\	/\<bin\>/
syntax	match	sclChartoint	contained
	\	/\<chartoint\>/
syntax	match	sclClock	contained
	\	/\<clock\>/
syntax	match	sclDigits	contained
	\	/\<digits\>/
syntax	match	sclFill	contained
	\	/\<fill\>/
syntax	match	sclFind	contained
	\	/\<find\>/
syntax	match	sclHextochar	contained
	\	/\<hextochar\>/
syntax	match	sclHex	contained
	\	/\<hex\>/
syntax	match	sclIndex	contained
	\	/\<index\>/
syntax	match	sclNumeric	contained
	\	/\<numeric\>/
syntax	match	sclStatus	contained
	\	/\<status\>/
syntax	match	sclStint	contained
	\	/\<stint\>/
syntax	match	sclSubstr	contained
	\	/\<substr\>/
syntax	match	sclEndswith	contained
	\	/\<endswith\>/
syntax	match	sclIncludes	contained
	\	/\<includes\>/
syntax	match	sclStartswith	contained
	\	/\<startswith\>/
syntax	match	sclEq	contained
	\	/=/
syntax	match	sclEq	contained
	\	/\<eq\>/
syntax	match	sclGe	contained
	\	/>=/
syntax	match	sclGe	contained
	\	/\<ge\>/
syntax	match	sclGt	contained
	\	/>/
syntax	match	sclGt	contained
	\	/\<gt\>/
syntax	match	sclLe	contained
	\	/<=/
syntax	match	sclLe	contained
	\	/\<le\>/
syntax	match	sclLt	contained
	\	/</
syntax	match	sclLt	contained
	\	/\<lt\>/
syntax	match	sclNe	contained
	\	/\<ne\>/
syntax	match	sclNot	contained
	\	/\<not\>/
syntax	match	sclAnd	contained
	\	/\<and\>/
syntax	match	sclOr	contained
	\	/\<or\>/
syntax	match	sclCount	contained
	\	/\<count\>/
syntax	match	sclLength	contained
	\	/\<length\>/
syntax	match	sclSval	contained
	\	/\<sval\>/
syntax	match	sclVal	contained
	\	/\<val\>/
syntax	match	sclAfter	contained
	\	/\<after\>/
syntax	match	sclBefore	contained
	\	/\<before\>/
syntax	match	sclNeq	contained
	\	/\<neq\>/
syntax	match	sclIs	contained
	\	/\<is\>/
syntax	match	sclAssignOp	contained
	\	/:\==/
syntax	match	sclPlus	contained
	\	/+/
syntax	match	sclMinus	contained
	\	/-/
syntax	match	sclMultiply	contained
	\	/\*/
syntax	match	sclDivide	contained
	\	/\//
syntax	match	sclAmpersand	contained
	\	/&/
syntax	match	sclComma	contained
	\	/,/
syntax	match	sclColon	contained
	\	/:/
syntax	match	sclSemiColon	contained
	\	/;/

