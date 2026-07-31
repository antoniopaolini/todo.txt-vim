" ============= function TagliaMarksEAppendi() [gemini]====== 2026-07-09 -AP-
" This function move marked tasks on another file in the same directory where
" is the actual edited todo file.
" It is useful if you want to organise tasks by files or to move "someday" 
" tasks in a long-term todo file in order to keep clean the main "todo.txt").
"
" Usage: 
"	1. Mark the lines to be moved away from the todo file.
"	   The classic marking method (ie. typing 'ma', 'mb', 'mc'...) can be used
"	   in combination with other methods (i.e. HLMarks plugin, etc)
"	2. execute :TagliaMarks
"	3. Will be prompted to enter the name of the file, whether new or existing.
"	   The lines will be moved to the new file or appended to it, if the file 
"	   already exists.
" 
"TODO: Translate all the comments (also the function names? Maybe not).
"TODO: integrare nel file delle funzioni (autoload\todo.vim?)
"
" Execution guard mechanism avoid multiple execution, for example if the file 
" is re-opened by `:e` (see :help ftplugin)
" If already loaded, we're done...
if exists("b:did_todo_move_task")
  finish
endif
let b:did_todo_move_task = 1

function! TagliaMarksEAppendi()
  let l:righe_trovate = {}

  " 1. Rileva tutte le righe associate ai mark da 'a' a 'z'
  for l:char in range(97, 122)
    let l:mark = nr2char(l:char)
    let l:num_riga = line("'" . l:mark)
    
    if l:num_riga > 0
      let l:righe_trovate[l:num_riga] = getline(l:num_riga)
    endif
  endfor

  " 2. Controllo di sicurezza se non ci sono mark
  if empty(l:righe_trovate)
    echo "Nessun mark minuscolo (a-z) trovato in questo file."
    return
  endif

  " 3. Ordina le chiavi numeriche in ordine decrescente (fondamentale per il taglio)
  let l:chiavi_ordinate_crescenti = sort(keys(l:righe_trovate), 'N')
  let l:chiavi_ordinate_decrescenti = reverse(copy(l:chiavi_ordinate_crescenti))

  " 4. Costruisce la lista di testo ordinata per il file di destinazione
  let l:testo_da_spostare = []
  for l:k in l:chiavi_ordinate_crescenti
    call add(l:testo_da_spostare, l:righe_trovate[l:k])
  endfor

  " 5. Chiede all'utente il nome del file con auto-completamento dei file locali
  call inputsave()
  let l:nome_file = input('Inserisci il nome del file di destinazione (Tab per completare): ', '', 'file')
  call inputrestore()

  " Ritorna se l'utente annulla l'operazione
  if empty(l:nome_file)
    echo "\nOperazione annullata."
    return
  endif

  " 6. Gestisce la scrittura/append sul file di destinazione
  let l:esiste = filereadable(l:nome_file)
  if l:esiste
    " Se il file esiste, legge il contenuto attuale e appende il nuovo testo
    let l:contenuto_esistente = readfile(l:nome_file)
    let l:nuovo_contenuto = l:contenuto_esistente + l:testo_da_spostare
    call writefile(l:nuovo_contenuto, l:nome_file)
  else
    " Se il file non esiste, lo crea da zero
    call writefile(l:testo_da_spostare, l:nome_file)
  endif

  " 7. Taglia (elimina) le righe dal file originale
  " Eliminando partendo dal basso (ordine decrescente), i numeri di riga in alto non cambiano
  for l:riga_da_cancellare in l:chiavi_ordinate_decrescenti
    execute l:riga_da_cancellare . 'delete _'
  endfor

  " 8. Feedback finale all'utente
  if l:esiste
    echo "\n" . len(l:testo_da_spostare) . " righe appese con successo a: " . l:nome_file
  else
    echo "\n" . len(l:testo_da_spostare) . " righe spostate nel NUOVO file: " . l:nome_file
  endif
endfunction

" Registra il comando personalizzato in Vim
command! TagliaMarks call TagliaMarksEAppendi()

