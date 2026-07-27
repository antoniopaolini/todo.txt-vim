" File:        qftodo.txt.vim
" Description: Todo.txt syntax settings included in quickfix window
" Author:      Antonio Paolin1
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.1.0  - 2026-07-26

" USAGE: 	:vimgrep // % | copen | setlocal syntax=qftodo
" TODO: 	Add mapping to the command above


" I’m not sure if the next three lines are needed
if exists("b:current_syntax")
    finish
endif

" FIXME: I'm not able to include qf syntax without re-adding the syn match
" definitions:
"syntax include @QF syntax/qf.vim
"unlet! b:current_syntax

syntax include @Todo syntax/todo.vim
unlet! b:current_syntax

silent! syntax clear TodoCol0

syn match	qfFileName	"^[^|]*"	   nextgroup=qfSeparator1
syn match	qfSeparator1	"|"	 contained nextgroup=qfLineNr
syn match	qfLineNr	"[^|]*"	 contained nextgroup=qfSeparator2 contains=@qfType
"
syntax clear qfSeparator2
syntax match qfSeparator2 "| " contained nextgroup=@TodoStart

let b:current_syntax = "qftodo"
