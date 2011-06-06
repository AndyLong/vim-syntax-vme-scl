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

let s:sclKeyWords={
	\	'Boolean': [ 'true', 'false' ],
	\	'Constant': [ 'nil' ],
	\	'Type': [ 'spd\k\+', 'proc', 'macro', 'int', 'bool', 'string', 'superstring', 'literal', 'superliteral', 'response' ],
	\	'StorageClass': [ 'ext', 'ref' ],
	\	'Reschedule': [ 'reschedule', 'noreschedule' ],
	\	'AssignOp': [ 'is' ],
	\	'RelOp': [ 'endswith', 'startswith', 'includes', 'eq', 'ne', 'lt', 'le', 'gt', 'ge' ],
	\	'BoolOp': [ 'and', 'or', 'not' ],
	\	'ArithOp': [ 'count', 'bound', 'length' ],
	\	'StringOp': [ 'and', 'or', 'neq', 'after', 'before', 'val', 'endswith', 'startswith', 'includes', 'eq', 'ne', 'lt', 'le', 'gt', 'ge' ],
	\	'SStringOp': [ 'sval' ],
	\	'Function': [ 'bin', 'chartoint', 'clock', 'digits', 'fill', 'find', 'hex', 'hextochar', 'index', 'numeric', 'status', 'stint', 'substr' ],
	\	'Statement': [ '\%(proc\|mac\)\=\%(begin\|end\)',  'goto',  'enter', 'syscall', 'return' ],
	\	'Repeat': [ 'for', 'from', 'by', 'to', 'while', 'until', 'do', 'repeat' ],
	\	'Conditional': [ 'if', 'unless', 'then', 'elsf', 'else', 'fi' ],
	\	'Exception': [ 'whenever' ]
	\	}

syntax	match	sclError	/\S\+/
syntax	match	sclError	/\k\+/

syntax	match	sclMandatoryDefault
	\	/\*/
"
"	Declare the pattern for Identifiers:-
"
"	1.	Starts with a letter
"	2.	Continues with alphanumeric or '_'
"	3.	Is not a language keyword
"
let list=[]
for [k,v] in items(s:sclKeyWords)
	call extend(list,v)
endfor
let scratch = join(list,'\|')
let scratch = 'syntax match sclIdentifier contained /\%(\<\%(' . scratch . '\)\>\)\@!\<\a\k*\>/'
exec scratch
unlet scratch
"
"	Parameter aliases need not follow the 'not a reserved word' condition
"
syntax	match	sclLaxIdentifier	contained /\<\a\k*\>/
"
syntax	match	sclUserName contained contains=sclColon,sclIdentifier
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
for [k,v] in items(s:sclKeyWords)
	let scratch = 'syntax match scl' . k . ' contained /\<\%(' . join(v,'\|') . '\)\>/'
	exec scratch
endfor
unlet scratch

syntax	match	sclRelOp	contained
	\	/=/
syntax	match	sclRelOp	contained
	\	/>=/
syntax	match	sclRelOp	contained
	\	/>/
syntax	match	sclRelOp	contained
	\	/<=/
syntax	match	sclRelOp	contained
	\	/</
syntax	match	sclAssignOp	contained
	\	/:\==/
syntax	match	sclStringOp	contained
	\	/+/
syntax	match	sclStringOp	contained
	\	/-/
syntax	match	sclArithOp	contained
	\	/+/
syntax	match	sclArithOp	contained
	\	/-/
syntax	match	sclArithOp	contained
	\	/\*/
syntax	match	sclArithOp	contained
	\	/\//
syntax	match	sclSStringOp	contained
	\	/&/
syntax	match	sclSeparator	contained
	\	/[,::]/
syntax	match	sclComma	contained
	\	/,/
syntax	match	sclSemiColon	contained
	\	/;/
syntax	match	sclColon	contained
	\	/:/
"
"	Now start building syntactic constructs from them
"
syntax	region	sclParen	fold keepend extend contains=@sclExpr,@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/[[({]/ end=/[])}]/

syntax	region	sclProcedureCall	keepend extend contains=sclFunction,
	\	sclIdentifier,sclActualParameters,@sclAlwaysValid
	\	start=/\<\a\k*\>\ze\s*[[({]/
	\	end=/[])}]\zs/
"
"	val & sva sometimes get confused with procedure calls, so declare them
"	*again* here
"
syntax	match	sclStringOp	contained
	\	/\<val\>/
syntax	match	sclSStringOp	contained
	\	/\<sval\>/

syntax	region	sclIntAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclIntExpr,@sclAlwaysValid
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
	\		sclAssignOp,@sclBoolExpr,@sclAlwaysValid
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
	\		sclAssignOp,@sclSStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze\<is\>\_s*/
	\	skip=/\(&\|\<is\>\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/
syntax	region	sclSStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclSStringExpr,@sclAlwaysValid
	\	start=/\<\a\k*\>\s*\ze:\==\_s*/
	\	skip=/\(&\|:\==\|+\|-\|\<and\>\|\<or\>\|\<after\|\<before\>\)\_s*/
	\	end=/\ze,/ end=/\ze;/ end=/$/

syntax	region	sclStringAssignment	fold keepend extend contains=sclIdentifier,
	\		sclAssignOp,@sclStringExpr,@sclAlwaysValid
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
	\		sclAssignOp,@sclExpr,@sclAlwaysValid
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

syntax	region	sclPragma	keepend extend contains=sclReschedule,
	\		@sclSStringExpr,@sclAlwaysValid
	\	matchgroup=sclParens
	\	start=/(/
	\	matchgroup=sclParens
	\	end=/)\_s*/

syntax	match	sclParameterAlias	extend contains=sclParens,sclLaxIdentifier,
	\		sclMandatoryDefault,@sclAlwaysValid
	\	/(\s*\S\+\s*)/

syntax	region	sclActualParameters	fold keepend contains=sclComment,
	\		@sclActualParameter
	\	matchgroup=sclParens
	\	start=/[[({]/
	\	matchgroup=sclParens
	\	end=/[])}]/

syntax	region	sclFormalParameters	fold keepend
	\		contains=sclAssignOp,sclParens,sclFormalParameter,sclType,@sclAlwaysValid
	\	start=/\<is\>\s*[[({]/
	\	end=/[])}]\(\s*\a\k*\>\)\=/

syntax	region	sclExtProcParameters	fold keepend
	\		contains=sclAssignOp,sclParens,sclExtProcParameter,sclType,@sclAlwaysValid
	\	start=/\<is\>\s*[[({]/
	\	end=/[])}]\(\s*\a\k*\>\)\=/

syntax	region	sclAnonymousParameter	keepend contained contains=@sclExpr,
	\		sclComment
	\	start=/\S/
	\	matchgroup=sclComma 
	\	end=/,/
syntax	match	sclAnonymousParameter	contains=sclComma
	\	/,/

syntax	region	sclNamedParameter keepend contained contains=sclOperator,@sclExpr,sclComment
	\	matchgroup=sclIdentifier
	\	start=/\<\a\k*\>\ze\s*:\==/
	\	matchgroup=sclComma 
	\	end=/,/

syntax	region	sclFormalParameter keepend contains=sclType,sclStorageClass,sclIdentifier,
	\		sclParameterAlias,sclAssignOp,@sclExpr,@sclAlwaysValid
	\	matchgroup=sclType
	\	start=/\<\(literal\|superliteral\|response\)\>/
	\	matchgroup=sclType
	\	start=/\<\(ref\s*\)\=\(int\|bool\|string\|superstring\)\>/
	\	matchgroup=sclPDef
	\	start=/\<\(spdx\|spdnull\|spdi\|spdt\|spdw\|spdb\|spdli\|spdlw\|spdri\|spdrli\|spdrw\|spdrlw\|spdrvb\|spdrvbw\|spdrvi\|spdrvw\|spdrvlw\|spdrt\|spdrb\|spdrvrvb\|spd[1-8]b\|spdr[1-8]b\)\>/
	\	matchgroup=sclComma 
	\	end=/,/
	\	matchgroup=sclParens
	\	end=/)/

syntax	region	sclExtProcParameter keepend contains=sclType,sclStorageClass,sclLaxIdentifier,
	\		sclMandatoryDefault,sclAssignOp,@sclExpr,@sclAlwaysValid
	\	matchgroup=sclType
	\	start=/\<\(literal\|superliteral\|response\)\>/
	\	matchgroup=sclType
	\	start=/\<\(ref\s*\)\=\(int\|bool\|string\|superstring\)\>/
	\	matchgroup=sclPDef
	\	start=/\<\(spdx\|spdnull\|spdi\|spdt\|spdw\|spdb\|spdli\|spdlw\|spdri\|spdrli\|spdrw\|spdrlw\|spdrvb\|spdrvbw\|spdrvi\|spdrvw\|spdrvlw\|spdrt\|spdrb\|spdrvrvb\|spd[1-8]b\|spdr[1-8]b\)\>/
	\	matchgroup=sclComma 
	\	end=/,/
	\	matchgroup=sclParens
	\	end=/)/

syntax	region	sclProcDeclaration	keepend containedin=NONE contains=sclType,sclIdentifier,sclPragma,sclFormalParameters,@sclAlwaysValid
	\	start=/\<proc\>\s\+\a\k*\s*\((\_.\{-})\)\=\s*\<is\>\s*[[({]/
	\	end=/[])}]\(\s*\a\k*\>\)\=/

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
	\	nextgroup=sclIntDeclaration,sclBoolDeclaration,sclExtProcDeclaration,
	\		sclStringDeclaration,sclSStringDeclaration,@sclAlwaysValid
	\	/\<ext\>\ze\s\+\S\+/

syntax	region	sclExtProcDeclaration	keepend contains=sclStorageClass,sclType,sclIdentifier,sclPragma,sclExtProcParameters,@sclAlwaysValid
	\	start=/\<ext\>\s\+\<proc\>\s\+\a\k*\s*\((\_.\{-})\)\=\s*\<is\>\s*[[({]/
	\	end=/[])}]\(\s*\a\k*\>\)\=/

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
	\	matchgroup=sclStatement start=/\<macbegin\>/
	\	matchgroup=sclStatement end=/\<macend\>/

syntax	region	sclBody	fold keepend contains=@sclStatements
	\	matchgroup=sclStatement start=/\<procbegin\>/
	\	matchgroup=sclStatement end=/\<procend\>/

syntax	region	sclBlock	fold keepend extend contains=@sclStatements
	\	matchgroup=sclStatement start=/\<begin\>/
	\	matchgroup=sclStatement end=/\<end\>/

syntax	region	sclForClause	fold keepend extend contained 
	\	contains=sclFromClause,sclToClause,sclByClause,sclWhileClause,
	\	sclUntilClause,sclIdentifier,@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<for\>/
	\	matchgroup=sclRepeat end=/\ze\_s*\<do\>/

syntax	region	sclFromClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<from\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclByClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<by\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclToClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<to\>/
	\	matchgroup=NONE end=/\ze\<\(by\|to\|do\|while\|until\)\>/

syntax	region	sclUntilClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<until\>/
	\	matchgroup=NONE end=/\ze\<\(by\|from\|do\|to\|while\)\>/

syntax	region	sclWhileClause	keepend extend contained contains=@sclExpr,
	\		@sclAlwaysValid
	\	matchgroup=sclRepeat start=/\<while\>/
	\	matchgroup=NONE end=/\ze\<\(by\|from\|do\|to\|until\)\>/

syntax	region	sclDoClause	fold keepend extend contained 
	\	contains=@sclStatements
	\	matchgroup=sclRepeat start=/\<do\>/
	\	matchgroup=sclRepeat end=/\<repeat\>/

syntax	region	sclUnlessClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause,sclElsfClause,sclElseClause
	\	matchgroup=sclUnless start=/\<unless\>/
	\	matchgroup=sclConditional end=/\<fi\>/

syntax	region	sclElsfClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause
	\	matchgroup=sclConditional start=/\<elsf\>/
	\	matchgroup=sclConditional 
	\	end=/\(\ze\<fi\>\|\ze\_s*\<else\>\|\ze\_s*\<elsf\>\)/

syntax	region	sclIfClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause,sclElsfClause,sclElseClause
	\	matchgroup=sclConditional start=/\<if\>/
	\	matchgroup=sclConditional end=/\<fi\>/

syntax	region	sclWheneverClause	keepend extend contained contains=@sclExpr,
	\		sclThenClause
	\	matchgroup=sclException start=/\<whenever\>/
	\	matchgroup=sclConditional end=/\<fi\>/

syntax	region	sclThenClause	fold keepend contained contains=@sclStatements
	\	matchgroup=sclConditional
	\	start=/\<then\>/
	\	matchgroup=sclConditional
	\	end=/\(\ze\<fi\>\|\ze\_s*\<else\>\|\ze\_s*\<elsf\>\)/

syntax	region	sclElseClause	fold keepend contained contains=@sclStatements
	\	matchgroup=sclConditional start=/\<else\>/
	\	matchgroup=sclConditional end=/\<fi\>/

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
	\		sclBoolOp,sclParen

syntax	cluster	sclIntOperand	contains=sclLocalName,sclIdentifier,sclNumber,
	\		sclProcedureCall,sclArithOp,sclParen

syntax	cluster	sclStringOperand	contains=sclIdentifier,sclStringConst,
	\		sclProcedureCall,sclStringOp,sclParen

syntax	cluster	sclSStringOperand	contains=sclIdentifier,sclStringConst,
	\		sclProcedureCall,sclSStringOp,sclParen

syntax	cluster	sclBoolExpr	contains=@sclBoolOperand,sclBoolOp,sclRelOp

syntax	cluster	sclIntExpr	contains=@sclIntOperand,sclRelOp,sclArithOp

syntax	cluster	sclStringExpr	contains=@sclStringOperand,sclRelOp,sclStringOp

syntax	cluster	sclSStringExpr	contains=@sclSStringOperand,sclRelOp,sclSStringOp

syntax	cluster	sclExpr	contains=@sclStringExpr,@sclSStringExpr,@sclIntExpr,
	\		@sclBoolExpr,sclAlwaysValid

syntax	cluster	sclAssignment	contains=sclIntAssignment,sclBoolAssignment,
	\		sclStringAssignment,sclSStringAssignment,sclAnonAssignment

syntax	cluster	sclDeclaration	contains=sclExtProcDeclaration,sclIntDeclaration,
	\		sclBoolDeclaration,sclStringDeclaration,sclSStringDeclaration,
	\		sclProcDeclaration,sclExtDeclaration,sclRowDeclaration

syntax	cluster	sclStatements	contains=sclIdentifier,sclBlock,sclIfClause,
	\		sclUnlessClause,sclWheneverClause,sclDoClause,sclForClause,
	\		sclFromClause,sclByClause,sclToClause,sclWhileClause,
	\		sclUntilClause,@sclAssignment,sclProcedureCall,
	\		@sclDeclaration,sclLabel,sclStatement,sclSemiColon,@sclAlwaysValid

syntax	cluster	sclAlwaysvalid	contains=sclComment,sclError
"
"	Noe assign all this to highlighting groups
"
if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink	sclIdentifier	Identifier
	HiLink	sclLaxIdentifier	Identifier
	HiLink	sclMandatoryDefault	Identifier

	HiLink	sclNumber	Number
	HiLink	sclHexNumber	Number

	HiLink	sclComment	Comment

	HiLink	sclConstant	Constant
	HiLink	sclAlienData	Constant
	HiLink	sclLabel	Constant

	HiLink	sclStringConst	String

	HiLink	sclType		Type
	HiLink	sclPDef		Type

	HiLink	sclStorageClass	StorageClass

	HiLink	sclBoolean	Boolean

	HiLink	sclOperator	Operator
	HiLink	sclAssignOp	Operator
	HiLink	sclRelOp	Operator
	HiLink	sclBoolOp	Operator
	HiLink	sclUnaryBoolOp	Operator
	HiLink	sclArithOp	Operator
	HiLink	sclUnaryArithOp	Operator
	HiLink	sclStringOp	Operator
	HiLink	sclSStringOp	Operator

	HiLink	sclFunction	Function

	HiLink	sclStatement	Statement

	HiLink	sclRepeat	Repeat

	HiLink	sclConditional	Conditional

	HiLink	sclException	Exception

	HiLink	sclSpecial	Special
	HiLink	sclReschedule	Special
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

let b:current_syntax = "scl"
