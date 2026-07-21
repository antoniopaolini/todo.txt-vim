" Cerca i task in cui sono citate le RP (attività di laboratorio e 'ripiega' 
" il resto del testo. 										2026-07-21 -AP-

" No-twice-execution check
if exists("b:did_FM_fold_RP") | finish | endif
let b:did_FM_fold_RP = 1



let g:cerca_epiega_attivo = 0
let g:cerca_epiega_saved_search = ''

function! RP_CercaEPiega_FAST()
    let l:RP_regex = '\d\{2,3}\.2'

    if g:cerca_epiega_attivo == 0
        " 1. Salva la tua ultima ricerca
        let g:cerca_epiega_saved_search = @/
        
        " 2. Imposta la regex numerica
        let @/ = l:RP_regex
        
        " 3. Richiama lo script originale di Conway per generare la struttura dei fold
        call FS_ToggleFoldAroundSearch({'context': 0})
        
        " 4. IL TRUCCO PER LE PRESTAZIONI: Congela i fold generati da Conway!
        " Cambiando il foldmethod in 'manual', la struttura visiva rimane identica,
        " ma Vim smette di eseguire lo script di Conway ad ogni movimento del cursore.
        set foldmethod=manual
        
        " 5. Ripristina subito la tua vera ricerca originale nei registri
        let @/ = g:cerca_epiega_saved_search
        
        let g:cerca_epiega_attivo = 1
    else
        " --- DISATTIVAZIONE ---
        " Per permettere a Conway di pulire i suoi fold, dobbiamo temporaneamente
        " rimettere il foldmethod che si aspettava (expr) e la regex numerica
        let @/ = l:RP_regex
        set foldmethod=expr
        
        " Chiama Conway per rimuovere i fold e gli autocomandi
        call FS_ToggleFoldAroundSearch({'context': 0})
        
        " Ripristina definitivamente la tua ricerca
        let @/ = g:cerca_epiega_saved_search
        
        let g:cerca_epiega_attivo = 0
    endif
endfunction


function! RP_CercaEPiega()
    " Variante regex ottimizzata con l'escape corretto per Vimscript
    let l:RP_regex = '\d\{2,3}\.2[56]'

    if g:cerca_epiega_attivo == 0
        " --- FASE 1: ATTIVAZIONE DEI FOLD ---
        " Salva la ricerca che l'utente stava effettuando prima
        let g:cerca_epiega_saved_search = @/
        
        " Imposta la nuova regex (indispensabile lasciarla attiva per foldsearches.vim)
        let @/ = l:RP_regex
        
        " Applica lo script di Conway
        call FS_ToggleFoldAroundSearch({'context': 0})
        
        " Cambia lo stato a 1 (attivo)
        let g:cerca_epiega_attivo = 1
    else
        " --- FASE 2: DISATTIVAZIONE E RIPRISTINO ---
        " Richiama lo script di Conway una seconda volta per rimuovere i fold
        call FS_ToggleFoldAroundSearch({'context': 0})
        
        " Ripristina in sicurezza il registro della ricerca originale dell'utente
        let @/ = g:cerca_epiega_saved_search
        
        " Resetta lo stato a 0 (disattivo)
        let g:cerca_epiega_attivo = 0
    endif
endfunction



" Mappatura silenziosa
nnoremap <silent> <leader>frp :call RP_CercaEPiega_FAST()<CR>
nnoremap <silent> <leader>rp :call RP_CercaEPiega()<CR>

