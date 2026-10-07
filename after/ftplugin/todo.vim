" File:        after/todo.vim
" Description: Todo.txt: useful commands mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.1.0  - 2026-10-01
"
" USAGE:       
"              :Weekline    Insert header week
" 				\wh			Mapping for the Weekline command



" Inserisce un header con la settimana corrente, nel seguente formato:
" ===================== week 40
" Altra versione: 
" command! Weekline put =repeat('=', 12) . ' week ' . strftime('%V')

command! WeekLine call append(line('.'), repeat('=', 21) . ' Week ' . strftime('%V'))
nnoremap <leader>wl	:WeekLine<CR>

"DONE: TODO: tengo \wh, week header, o lo rinomino in wl, week line?
"------------------------------------------------------------------------



