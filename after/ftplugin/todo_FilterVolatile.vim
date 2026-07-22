" File:        after/todo_FilterVolatile.vim
" Description: Todo.txt syntax settings,mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     FIXME http://github.com/dbeniamine/todo.txt-vim

" If I defined these commands also in my vimrc I can set also the next guard
" variable, in order to not execute twice this code.a
" If I want to disable from vimrc the variable scope should be relative to 
" the Window (w:) or Global (g:)
if exists("w:did_todo_FilterVolatile") | finish | endif
let w:did_todo_FilterVolatile = 0

"________________________________________________________Modifiche -AP- 2025-11-14
"Aggiungo una funzione di filtro per cercare velocemente tra i task

command! -nargs=? FilterVolatile let @a='' | execute 'g/<args>/y A' | let syn_buffer = get(b:, 'current_syntax', '') | new | execute 'setlocal bt=nofile syn=' . syn_buffer | put! a | noh
command -nargs=? FV FilterVolatile <args>
"E questa sotto ripete l'ultima ricerca:
nnoremap <leader>FV :FV<CR>
