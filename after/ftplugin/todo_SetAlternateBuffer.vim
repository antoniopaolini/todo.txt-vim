" File:        after/todo_SetAlternateBuffer.vim
" Description: Todo.txt syntax settings, mapping and other improvements
" Author:      Antonio Paolini (with Gemini support)
" License:     Vim license
" Website:     http://github.com/antoniopaolini/todo.txt-vim
" Revision:    v0.1.0 - 2026-11-09
" Description: This function automatically sets the alternate file if there
"              are only two buffers open.
"
" Note:        I'm used to open two buffers, TODO.txt and Done.txt and I
"              switch between them in order to add some task directly to the
"              done file (I use it as job log, then if I do a task not
"              planned I add it directly to the done.txt)
"              In order to disable this function set in the .vimrc the
"              variable 'not_set_alternate_buffer_todo':
"                   set g:not_set_alternate_buffer_todo=1


function! SetAlternateBuffer()
  " Conta il numero di buffer caricati nella lista
  " TODO: L'opzione "hidden" ha effetti su questa funzione?
  let l:listed_buffers = len(getbufinfo({'buflisted': 1}))

  if l:listed_buffers == 2
    " Trova l'ID del buffer alternativo usando il comando nativo di Vim
    " (Prende il primo buffer della lista; se è quello corrente, prende il secondo)
    let l:all_bufs = map(getbufinfo({'buflisted': 1}), 'v:val.bufnr')
    let l:alt = l:all_bufs[0] == bufnr('%') ? l:all_bufs[1] : l:all_bufs[0]

    " Imposta l'alternate file solo se non è già corretto
    " TODO: Serve questa condizione o posso impostarlo direttamente nella
    " definizione di l:alt? Ci sono altri casi che lo rendono necessario?
    if @# != l:alt
      let @# = l:alt
    endif
  endif
endfunction

"autocmd BufEnter * call SetAlternateBuffer()
" I'll set this variable in vimrc only if I don't want
" to auto set alternate buffer
if !exists('g:not_set_alternate_buffer_todo')
  augroup todoAlternateBuffer
    autocmd!
    autocmd BufEnter * call SetAlternateBuffer()
  augroup END
endif
