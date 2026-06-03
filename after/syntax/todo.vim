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
syntax  match   TodoWaitingFrom  '\s\zs◀\S*'  contains=NONE
syntax  match   TodoReplyTo      '\s\zs▶\S*'  contains=NONE

hi default link     TodoWaitingFrom DiffAdd
hi default link     TodoReplyTo     DiffDelete
"hi default link    TodoReplyTo     SpellBad
"
" Two maps to save me from digit digraph (<CTRL-k>PL = "◀",  <CTRL-k>PR = "▶")
imap > ▶
imap < ◀

"________________________________________________________Modifiche -AP- 2025-11-14
"Aggiungo una funzione di filtro per cercare velocemente tra i task
"(Per ora la metto in questo file, poi la sposterò in after/plugin? O metto
"tutto solo in "after"?
"Risposta: in ftplugin!)
"2026-04-29: la metto nel vimrc per averla disponibile sempre.
"command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile syn=todo | put! a | noh
""Filter & show in a Volatile buffer (TODO: si può fare un map? R: si, vedi function NarrowSearch nel mio vimrc )
"command -nargs=? FV Filter <args>


"________________________________________________________Modifiche -AP- 2026-05-26
"Definisco una evidenziazione per le righe di intestazione del plugin NrrwRgn,
"per renderle meno evidenti.
syntax match NrrwRgnDelim '^\/\*.*\*\/'
hi default link NrrwRgnDelim Ignore
"hi default link NrrwRgnDelim PmenuThumb

