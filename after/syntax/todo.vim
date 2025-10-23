" File:        after/todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      Antonio Paolini
" License:     Vim license
" Website:     FIXME http://github.com/dbeniamine/todo.txt-vim



"________________________________________________________Modifiche -AP- 2024-10-21
" Aggiungo la possibilità di inserire una riga di titolo per i progetti
" La metto in "after" poiché non è una caratteristica specifica del formato
" todo.txt.
" Mi piace il bold,reverse, ma anche il bold,underline non era male
syntax  match   TodoProjectTitle   '^\(=\|_\)\+.*$'  contains=NONE
"syntax  match   TodoProjectTitle   '^\(=\|_\)\+\(\s\(\w\|=\)\+\)*$'  contains=NONE
"hi TodoProjectTitle  cterm=bold,underline guifg=#0000ff gui=bold,underline
hi TodoProjectTitle  cterm=bold,underline guifg=#0000ff gui=bold,reverse
"________________________________________________________Modifiche -AP- 2025-10-23
" Aggiungo la possibilità di inserire la relazione con altri, asd esempio se
" devo dare una risposta a qualcuno o se aspetto la fine dell'attività di
" qualcuno per poter procedere. 
" Li vado a etichettare con "WaitingFrom" (◀) e "ReplyTo" (▶)
syntax  match   TodoWaitingFrom  '\s\zs◀\S*'  contains=NONE
syntax  match   TodoReplyTo      '\s\zs▶\S*'  contains=NONE

hi default link 	TodoWaitingFrom	DiffAdd
hi default link 	TodoReplyTo		DiffDelete
"hi default link 	TodoReplyTo		SpellBad
