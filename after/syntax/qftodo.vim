" File:        qftodo.txt.vim
" Description: Todo.txt syntax settings included in quickfix window
" Author:      Antonio Paolin1
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.2.0  - 2026-09-29

" USAGE:    :vimgrep // % | copen | setlocal syntax=qftodo
" TODO: 	Add mapping to the command above 
" DONE:     2026-09-29: Added command and mapping in after\ftplugin\todo_FilterQuickFix.vim

" I’m not sure if the next three lines are needed
if exists("b:current_syntax")
    finish
endif

" FIXME: I'm not able to include qf syntax without re-adding the syn match definitions.
" UPDATE: Using "runtime" instead of "syntax include" works. 
" DONE:  I leave this note for reference.
"syntax include @QF syntax/qf.vim
"unlet! b:current_syntax

runtime! syntax/qf.vim
unlet! b:current_syntax

syntax include @Todo syntax/todo.vim
unlet! b:current_syntax

silent! syntax clear TodoCol0

syntax clear qfSeparator2
syntax match qfSeparator2 "| " contained nextgroup=@TodoStart

let b:current_syntax = "qftodo"
