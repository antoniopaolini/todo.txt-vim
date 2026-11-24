" File:        after/todo_AutoSave.vim
" Description: Todo.txt syntax settings, mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.1.0 - 2026-11-24
" Description: This script add autosave option to TODO and DONE buffer.
"
" Note:        Sometimes I put a task in my todo but switch to another window
"              or activity. Then when I return to my todo list I don't know
"              if I need to save because I changed something or if there's a
"              unwanted change.
"              With this every time I stop work on my todo list and change
"              context the file is saved. Moreover I can switch to the
"              alternate buffer (done.txt) without manual save.
"
"              In order to disable this function set in the .vimrc the
"              variable 'not_set_autosave_todo':
"                   set g:not_set_autosave_todo=1


if !exists('g:not_autosave_todo')
	"TODO: evaluate autowriteall
	set autowrite 
  augroup todoAutoSave
    autocmd!
	"autocmd InsertLeave,FocusLost <buffer> silent! write
	autocmd FocusLost <buffer> silent! write
  augroup END
endif
