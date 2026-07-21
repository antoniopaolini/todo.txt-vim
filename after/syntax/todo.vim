" File:        after/todo.txt.vim
" Description: Todo.txt syntax settings,mapping and other improvements
" Author:      Antonio Paolini
" License:     Vim license
" Website:     FIXME http://github.com/dbeniamine/todo.txt-vim



"________________________________________________________Modifiche -AP- 2024-10-21
" Aggiungo la possibilità di inserire una riga di titolo per i progetti
" La metto in "after" poiché non è una caratteristica specifica del formato
" todo.txt.
" Mi piace il bold,reverse, ma anche il bold,underline non era male

syntax  match   TodoProjectTitle   '^\(=\|_\)\+.*$'  contains=NONE
syntax  match   TodoProjectTitle   '^\(▶\|_\)\+.*$'  contains=NONE
"syntax  match   TodoProjectTitle   '^\(=\|_\)\+\(\s\(\w\|=\)\+\)*$'  contains=NONE
"hi TodoProjectTitle  cterm=bold,underline guifg=#0000ff gui=bold,underline
hi TodoProjectTitle  cterm=bold,underline guifg=#0000ff gui=bold,reverse

"________________________________________________________Modifiche -AP- 2025-10-23
" Aggiungo la possibilità di inserire la relazione con altri, ad esempio se
" devo dare una risposta a qualcuno o se aspetto la fine dell'attività di
" qualcuno per poter procedere.
" Li vado a etichettare con "WaitingFrom" (◀) e "ReplyTo" (▶)
"________________________________________________________Modifiche -AP- 2026-07-15
" Aggiungo la gestione con "cluster e contains" perché altrimenti ne vedo
" l'evidenziazione solo se non ce ne sono altre, cioè ad esempio se c'è una
" priorità prendono l'evidenziazione della priorità.
" Devo fare la modifica nel file syntax!  Definisco il seguente cluster.
" syntax cluster TodoAssignment contains=TodoWaitingFrom,TodoReplyTo

syntax  match   TodoWaitingFrom  '\s\zs◀\S*'  contains=NONE
syntax  match   TodoReplyTo      '\s\zs▶\S*'  contains=NONE

hi default link     TodoWaitingFrom DiffAdd
hi default link     TodoReplyTo     DiffDelete
"hi default link    TodoReplyTo     SpellBad
"
" Two maps to save me from digit digraph (<CTRL-k>PL = "◀",  <CTRL-k>PR = "▶")
imap > ▶
imap < ◀

"________________________________________________________Modifiche -AP- 2026-05-26
"Definisco una evidenziazione per le righe di intestazione del plugin NrrwRgn,
"per renderle meno evidenti.
syntax match NrrwRgnDelim '^\/\*.*\*\/'
hi default link NrrwRgnDelim Ignore
"hi default link NrrwRgnDelim PmenuThumb

