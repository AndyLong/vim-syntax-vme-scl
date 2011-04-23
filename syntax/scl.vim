" VIM Syntax File
" Language:	ICL/Fujitsu VME SCL programs
" Maintainer:	Andy Long (Andrew.Long@Yahoo.com)
" LastChange:	$Date$
" version: 	$Revision$
" Remarks:	VME SCL is the System Control Language (JCL, to IBM-heads)
" 		for the (formerly) ICL (now) Fujitsu mainframe VME systems.
"
"	$Log: scl.vim,v $
"
if version<600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax	case	ignore

syntax	sync	fromstart

syntax	match	sclError	/\S\+/
syntax	match	sclError	/\k\+/

syntax	match	sclMandatoryDefault contains=sclMultiply
	\	/\*/

syntax	match	sclIdentifier contained
	\	/\<\a\k*\>/
"
syntax	match	sclUserName contained contains=sclMultiply,sclIdentifier
	\	/:\<\a\k*\>/
syntax	match	sclLocalName contained contains=sclMultiply,sclIdentifier
	\	/\*\<\a\k*\>/
"
"	All SCL Numbers are integers
"
syntax	match	sclNumber	/\<\d\+\>/	contained
syntax	match	sclNumber	/-\s*\<\d\+\>/	contained
"
"	Unless they're Hex literals.....
"
syntax	match	sclHexNumber	/\<[0-9a-f]\+\>/	contained

syntax	match	sclStringEsc1 contained
	\	/""/
syntax	match	sclStringEsc2 contained
	\	/''/

syntax	region	sclError oneline keepend extend contains=sclStringEsc1
	\	start=/"/ end=/$/
syntax	region	sclError oneline keepend extend contains=sclStringEsc2
	\	start=/'/ end=/$/
syntax	region	sclStringConst oneline keepend extend contains=sclStringEsc1
	\	start=/"/ skip=/""/ end=/"/
syntax	region	sclStringConst oneline keepend extend contains=sclStringEsc2
	\	start=/'/ skip=/''/ end=/'/
syntax	match	sclStringConst
	\	/""/
syntax	match	sclStringConst
	\	/''/

syntax	match	sclParens	contained /[([{})\]]/

syntax	keyword	sclTodo containedin=sclComment
	\	TODO	FIXME	FIXTHIS
"
"	read the reserved words in the language 
"
runtime	syntax/scl/reservedWords.vim
"
"	Now start building syntactic constructs from them
"
syntax	region	sclParen	fold keepend extend contains=@sclExpr,@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/[[({]/ end=/[])}]/

syntax	region	sclProcedureCall	keepend extend contains=sclIdentifier,
	\	@sclFunction,sclActualParameters,@sclAlwaysValid
	\	start=/\<\a\k*\>\ze\s*[[({]/
	\	end=/[])}]\zs/

syntax	region	sclIntAssignment	fold keepend extend contains=sclIdentifier,
	\		sclIs,@sclIntExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(\<is\>\|\*\|\/\|-\|+\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclIntAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclIntExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(:\==\|\*\|\/\|-\|+\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclIntAssignment	fold keepend extend 
	\	contains=sclProcedureCall,sclAssignOp,@sclIntExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*[[({]\_.\{-}[])}]\s*\ze:\==\_s*/
	\	skip=/\(:\==\|\*\|\/\|-\|+\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclBoolAssignment	fold keepend extend contains=sclIdentifier,
	\		sclIs,@sclBoolExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(\<is\>\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclBoolAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclBoolExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(:\==\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclBoolAssignment	fold keepend extend 
	\	contains=sclProcedureCall,sclAssignOp,@sclBoolExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*[[({]\_.\{-}[])}]\s*\ze:\==\_s*/
	\	skip=/\(:\==\|\<and\>\|\<or\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclSStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclIs,@sclSStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(&\|\<is\>\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclSStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclSStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(&\|:\==\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclIs,@sclStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(\<is\>\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(:\==\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclStringAssignment	fold keepend extend 
	\	contains=sclProcedureCall,sclAssignOp,@sclStringExpr,
	\		@sclAlwaysValid
	\	start=/\<\a\k*\>\s*[[({]\_.\{-}[])}]\s*\ze:\==\_s*/
	\	skip=/\(:\==\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclStringAssignment	fold keepend extend 
	\	contains=sclProcedureCall,sclAssignOp,@sclStringExpr,@sclAlwaysValid
	\	start=/\<substr\>\s*[[({]\_.\{-}[])}]\s*\ze:\==\_s*/
	\	skip=/\(:\==\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclAnonAssignment	fold keepend extend contains=sclIdentifier,
	\		sclIs,@sclExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(\<is\>\|+\|-\|\*\|\/\|\<and\>\|\<or\>\|\<after\|\<before\>\|&\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclAnonAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(:\==\|+\|-\|\*\|\/\|\<and\>\|\<or\>\|\<after\|\<before\>\|&\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclAnonAssignment	fold keepend extend 
	\	contains=sclProcedureCall,sclAssignOp,@sclExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*[[({]\_.\{-}[])}]\s*\ze:\==\_s*/
	\	skip=/\(:\==\|+\|-\|\*\|\/\|\<and\>\|\<or\>\|\<after\|\<before\>\|&\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclStringAdvisoryLength	keepend extend contains=@sclIntExpr,
	\		sclComment,sclError
	\	matchgroup=sclParens
	\	start=/(/
	\	matchgroup=sclParens
	\	end=/)\_s*/
syntax	region	sclSStringAdvisoryLength	keepend extend contains=sclComma,
	\		@sclIntExpr,@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/(/
	\	matchgroup=sclParens
	\	end=/)\_s*/

syntax	region	sclPragma	keepend extend contains=sclNoReschedule,
	\		sclReschedule,@sclSStringExpr,@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/(/
	\	matchgroup=sclParens
	\	end=/)\_s*/

syntax	match	sclParameterAlias	extend contains=sclParens,sclIdentifier,
	\		sclMandatoryDefault,@sclAlwaysValid
	\	/(\s*\S\+\s*)/

syntax	match	sclBoolean
	\	/\<\(true\>\|\<false\)\>/

syntax	match	sclType
	\	/\<\(bool\|int\|literal\|superliteral\|proc\|response\|\<string\>\|\<superstring\)\>/

syntax	region	sclActualParameters	fold keepend contains=sclComment,
	\		@sclActualParameter
	\	matchgroup=sclParens
	\	start=/[[({]/
	\	matchgroup=sclParens
	\	end=/[])}]/

syntax	region	sclFormalParameters	fold keepend skipwhite skipempty 
	\		nextgroup=sclType contains=sclFormalParameter,
	\		@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/[[({]/
	\	matchgroup=sclParens
	\	end=/[)}\]]/

syntax	region	sclAnonymousParameter	keepend contained contains=@sclExpr,
	\		sclComment
	\	start=/\S/
	\	matchgroup=sclComma 
	\	end=/,/
syntax	match	sclAnonymousParameter	contains=sclComma
	\	/,/

syntax	region	sclNamedParameter keepend contained contains=sclIdentifier,
	\		sclAssignOp,@sclExpr,sclComment
	\	start=/\<\a\k*\>\s*:\==/
	\	matchgroup=sclComma 
	\	end=/,/

syntax	region	sclFormalParameter keepend contains=sclType,sclRef,sclIdentifier,
	\		sclParameterAlias,sclAssignOp,@sclExpr,@sclAlwaysValid
	\	start=/\<\(literal\|superliteral\|response\)\>/
	\	start=/\<\(ref\s*\)\=\(int\|bool\|string\|superstring\)\>/
	\	matchgroup=sclComma 
	\	end=/,/

" syntax	match	sclProcDeclaration	contains=sclType skipwhite skipempty 
" 	\	nextgroup=sclIdentifier
" 	\	/\<proc\>/
syntax	match	sclProcDeclaration	skipwhite skipempty 
	\	nextgroup=sclFormalParameters
	\	contains=sclType,sclIdentifier,sclPragma,sclIs,@sclAlwaysValid
	\	/\<proc\>\s\+\a\k*\s*\((\_.\{-})\)\=\s*\<is\>\ze/

syntax	region	sclBoolDeclaration	fold keepend extend contains=sclType,
	\		sclBoolAssignment,sclIdentifier,sclComment,sclComma,
	\		@sclAlwaysValid
	\	start=/\ze\<bool\>/
	\	skip=/\(\<bool\>\|,\)\_s*/
	\	matchgroup=sclSemiColon
	\	end=/;/ end=/$/

syntax	region	sclIntDeclaration	fold keepend extend contains=sclType,
	\		sclIntAssignment,sclIdentifier,sclComment,sclComma,
	\	@sclAlwaysValid
	\	start=/\ze\<int\>/
	\	skip=/\(\<int\>\|,\)\_s*/
	\	matchgroup=sclSemiColon
	\	end=/;/ end=/$/

syntax	region	sclStringDeclaration	fold keepend extend contains=sclType,
	\		sclStringAdvisoryLength,sclStringAssignment,sclIdentifier,
	\		sclComma,@sclAlwaysValid
	\	start=/\ze\<string\>/
	\	skip=/\(\<string\>\|)\|,\)\_s*/
	\	matchgroup=sclSemiColon
	\	end=/;/ end=/$/

syntax	region	sclSStringDeclaration	fold keepend extend
	\	contains=sclType,sclSStringAdvisoryLength,sclSStringAssignment,
	\		sclIdentifier,sclComma,@sclAlwaysValid
	\	start=/\ze\<superstring\>/
	\	skip=/\(\<superstring\>\|)\|,\)\_s*/
	\	matchgroup=sclSemiColon
	\	end=/;/ end=/$/
"
"	And these are the higher level constructs
"
syntax	match 	sclExtDeclaration	contained contains=sclExt skipwhite
	\	nextgroup=sclProcDeclaration,sclIntDeclaration,sclBoolDeclaration,
	\		sclStringDeclaration,sclSStringDeclaration,@sclAlwaysValid
	\	/\<ext\>\ze\s\+\S\+/

syntax	region 	sclRowDeclaration	contained keepend extend 
	\	contains=@sclIntExpr skipwhite
	\	nextgroup=sclInt,sclBoolsclError
	\	matchgroup=sclParens 
	\	start=/(/ end=/)/

syntax	region	sclComment
	\	extend
	\	start=/@/ end=/\n/ end=/@/ 
syntax	region	sclComment contained
	\	extend
	\	start=/@/ end=/\n/ end=/@/ 

syntax	region	sclBody	fold keepend contains=@sclStatements
	\	matchgroup=sclMacbegin start=/\<macbegin\>/
	\	matchgroup=sclMacend end=/\<macend\>/

syntax	region	sclBody	fold keepend contains=@sclStatements
	\	matchgroup=sclProcbegin start=/\<procbegin\>/
	\	matchgroup=sclProcend end=/\<procend\>/

syntax	region	sclBlock	fold keepend extend contains=@sclStatements
	\	matchgroup=sclBegin start=/\<begin\>/
	\	matchgroup=sclEnd end=/\<end\>/

syntax	region	sclForClause	fold keepend extend contained 
	\	contains=sclFromClause,sclToClause,sclByClause,sclWhileClause,
	\	sclUntilClause,sclIdentifier,@sclAlwaysValid
	\	matchgroup=sclFor start=/\<for\>/
	\	matchgroup=sclDo end=/\ze\_s*\<do\>/

syntax	region	sclFromClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclFrom start=/\<from\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclByClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=scLby start=/\<by\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclToClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclto start=/\<to\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclUntilClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclUntil start=/\<until\>/
	\	matchgroup=NONE end=/\ze\<\(by\|from\|do\|to\|while\)\>/

syntax	region	sclWhileClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclWhile start=/\<while\>/
	\	matchgroup=NONE end=/\ze\<\(by\|from\|do\|to\|until\)\>/

syntax	region	sclDoClause	fold keepend extend contained 
	\	contains=@sclStatements
	\	matchgroup=sclDo start=/\<do\>/
	\	matchgroup=sclRepeat end=/\<repeat\>/

syntax	region	sclUnlessClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause,sclElsfClause,sclElseClause
	\	matchgroup=sclUnless start=/\<unless\>/
	\	matchgroup=sclFi end=/\<fi\>/

syntax	region	sclElsfClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause
	\	matchgroup=sclElsf start=/\<elsf\>/
	\	matchgroup=sclFi 
	\	end=/\(\ze\<fi\>\|\ze\_s*\<else\>\|\ze\_s*\<elsf\>\)/

syntax	region	sclIfClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause,sclElsfClause,sclElseClause
	\	matchgroup=sclIf start=/\<if\>/
	\	matchgroup=sclFi end=/\<fi\>/

syntax	region	sclWheneverClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause
	\	matchgroup=sclWhenever start=/\<whenever\>/
	\	matchgroup=sclFi end=/\<fi\>/

syntax	region	sclThenClause	fold keepend contained contains=@sclStatements
	\	matchgroup=sclThen
	\	start=/\<then\>/
	\	matchgroup=sclFi
	\	end=/\(\ze\<fi\>\|\ze\_s*\<else\>\|\ze\_s*\<elsf\>\)/

syntax	region	sclElseClause	fold keepend contained contains=@sclStatements
	\	matchgroup=sclElse start=/\<else\>/
	\	matchgroup=sclFi end=/\<fi\>/

syntax	region	sclAlienData fold keepend extend
	\	start=/^----\s*$/ end=/^++++\s*$/

syntax	match	sclLabel
	\	contained
	\	/^\s*\a\k*\s*:\([^=]\|$\)/
"
"	These clusters group useful types together
"
syntax	cluster	sclActualParameter	contains=sclAnonymousParameter,
	\		sclNamedParameter

syntax	cluster	sclBoolOperand	contains=sclIdentifier,sclBoolean,sclProcedureCall,
	\		sclIdentifierSubscr,sclUnaryBoolOp,sclParen

syntax	cluster	sclIntOperand	contains=sclLocalName,sclIdentifier,sclNumber,
	\		sclProcedureCall,
	\		sclIdentifierSubscr,sclUnaryArithOp,sclParen

syntax	cluster	sclStringOperand	contains=sclIdentifier,sclStringConst,
	\		sclProcedureCall,sclIdentifierSubscr,sclVal,@sclStringOp,
	\		sclParen

syntax	cluster	sclSStringOperand	contains=sclIdentifier,sclStringConst,
	\		sclProcedureCall,sclIdentifierSubscr,sclSval,@sclSStringOp,
	\		@sclStringOp,sclParen

syntax	cluster	sclRelOp	contains=sclEndsWith,sclIncludes,sclStartsWith,
	\		sclEq,sclGe,sclGt,sclLe,sclLt,sclNe

syntax	cluster	sclUnaryBoolOp	contains=sclNot

syntax	cluster	sclBoolOp	contains=sclAnd,sclOr

syntax	cluster	sclUnaryArithOp	contains=sclPlus,sclMinus,sclCount,sclBound,
	\		sclLength	
syntax	cluster	sclArithOp	contains=sclPlus,sclMinus,sclMultiply,sclDivide

syntax	cluster	sclSStringOp	contains=sclAmpersand

syntax	cluster	sclStringOp	contains=sclAfter,sclBefore,sclNeq,sclAnd,sclOr,
	\		sclPlus,sclMinus

syntax	cluster	sclBoolExpr	contains=@sclBoolOperand,@sclUnaryBoolOp,@sclBoolOp,@sclRelOp

syntax	cluster	sclIntExpr	contains=@sclIntOperand,@sclRelOp,@sclArithOp,@sclUnaryArithOp

syntax	cluster	sclStringExpr	contains=@sclStringOperand,@sclRelOp,@sclStringOp

syntax	cluster	sclSStringExpr	contains=@sclSStringOperand,@sclRelOp,@sclSStringOp

syntax	cluster	sclExpr	contains=@sclStringExpr,@sclSStringExpr,@sclIntExpr,
	\		@sclBoolExpr,sclAlwaysValid

syntax	cluster	sclFunction	contains=sclBin,sclChartoint,sclClock,sclDigits,
	\		sclFill,sclFind,sclHex,sclHextochar,sclIndex,sclNumeric,
	\		sclStatus,sclStint,sclSubstr

syntax	cluster	sclAssignment	contains=sclIntAssignment,sclBoolAssignment,
	\		sclStringAssignment,sclSStringAssignment,sclAnonAssignment

syntax	cluster	sclDeclaration	contains=sclIntDeclaration,sclBoolDeclaration,
	\		sclStringDeclaration,sclSStringDeclaration,
	\		sclProcDeclaration,sclExtDeclaration,sclRowDeclaration

syntax	cluster	sclStatements	contains=sclIdentifier,sclBlock,sclIfClause,
	\		sclUnlessClause,sclWheneverClause,sclDoClause,sclForClause,
	\		sclFromClause,sclByClause,sclToClause,sclWhileClause,
	\		sclUntilClause,@sclAssignment,sclProcedureCall,
	\		@sclDeclaration,sclLabel,sclReturn,sclGoto,sclEnter,
	\		sclSyscall,sclSemiColon,@sclAlwaysValid

syntax	cluster	sclAlwaysvalid	contains=sclComment,sclError
"
"	Noe assign all this to highlighting groups
"
runtime	syntax/scl/highlights.vim

let b:current_syntax = "scl"
