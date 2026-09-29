" File:        after/todo_FilterQuickFix.vim
" Description: Todo.txt syntax settings, mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.1.0  - 2026-09-29
" Description: These commands open quickfix buffer with the last search (map) or new keyword (command)
"
" USAGE:       \FX             will open quickfix buffer with last search pattern
"              :FX keyword     will open quickfix buffer looking for "keyword"


" If I defined these commands also in my vimrc I can set also the next guard
" variable, in order to not execute twice this code.
" If I want to disable from vimrc the variable scope should be Global (g:)
if exists("g:did_todo_FilterQuickFix") | finish | endif
let g:did_todo_FilterQuickFix = 1

" `<LEADER>FX` open quickfix for the last search pattern
nmap FX :vimgrep // % \| copen \| setlocal syntax=qftodo<CR>

" `:FX keyword` open quickfix with the new pattern inserted in the command
command! -nargs=? FX execute 'vimgrep <args> %' |  copen | setlocal syntax=qftodo


" NOTE: 2026-09-29 -AP-
" La versione con l'autocommand, queste due righe sotto, è  molto elegante perché 
" applica la sintassi al buffer quickfix solo se il file dal quale  partiamo è un 
" file todo.txt. Ma mettendo le definizioni di questi comandi nel plugin todo.txt
" li avremo disponibili solo per i file "todo", quindi il problema non si pone.
"
"nmap FX :vimgrep // % \| copen<CR>
"autocmd BufReadPost quickfix if getbufvar('#', '&filetype') == 'todo' | setlocal syntax=qftodo | endif
"
