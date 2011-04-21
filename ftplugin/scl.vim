" My SCL FileType Plugin file
"
" Only do this if the buffer has not been initialised
"
if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin=1

setlocal softtabstop=4
setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal foldcolumn=4
setlocal foldmethod=syntax

if !exists("b:scl_fold_parentheses")
	let b:scl_fold_parentheses=0
endif

if !exists("b:scl_fold_declarations")
	let b:scl_fold_declarations=0
endif

if !exists("b:scl_fold_assignments")
	let b:scl_fold_assignments=0
endif

if !exists("b:scl_fold_body")
	let b:scl_fold_body=0
endif

if !exists("b:scl_fold_blocks")
	let b:scl_fold_blocks=1
endif

if !exists("b:scl_fold_loops")
	let b:scl_fold_loops=1
endif

if !exists("b:scl_fold_conditionals")
	let b:scl_fold_conditionals=1
endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croqla

" Set 'comments' to SCL Comments
setlocal com=:\@

" Format comments to be up to 78 characters long
setlocal tw=78

" Comments start with an 'at' (@) sign
setlocal commentstring=\@%s

" Configure the 'matchit' plugin
let b:match_words = '\<\(if\|unless\)\>:\<then\>:\<elsf\>:\<then\>:\<else\>:\<fi\>,\<whenever\>:\<then\>:\<fi\>,\<procbegin\>:\<procend\>,\<begin\>:\<end\>,\<do\>:\<repeat\>'
