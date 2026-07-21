" File:        after/todo_FilterVolatile.vim
" Description: Todo.txt syntax settings,mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     FIXME http://github.com/dbeniamine/todo.txt-vim

" If I defined these commands also in my vimrc I can set also the next guard
" variable, in order to not execute twice this code.
if exists("b:did_todo_FilterVolatile") | finish | endif
let b:did_todo_FilterVolatile = 1

"________________________________________________________Modifiche -AP- 2025-11-14
"Aggiungo una funzione di filtro per cercare velocemente tra i task

command! -nargs=? FilterVolatile let @a='' | execute 'g/<args>/y A' | let syn_buffer = get(b:, 'current_syntax', '') | new | execute 'setlocal bt=nofile syn=' . syn_buffer | put! a | noh
command -nargs=? FV FilterVolatile <args>
"E questa sotto ripete l'ultima ricerca:
nnoremap <leader>FV :FV<CR>
