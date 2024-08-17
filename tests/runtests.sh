#!/bin/bash

REPO_TOP=$(git rev-parse --show-toplevel)
cd "${REPO_TOP}"

echo "Check for Vader"
echo "---------------"
vim -Nu <(cat <<EOF
function! s:chk_vader_exists()
    if exists(":Vader")
        cquit 0
    else
        echom 'Vader not found. Please install it.'
        echom 'https://github.com/junegunn/vader.vim'
        cquit 1
    endif
endfunction

command! ChkVaderExists call s:chk_vader_exists()
EOF
) '+ChkVaderExists' || exit 1

echo "Basic environment"
echo "-----------------"
vim -Nu <(cat <<EOF
filetype off
set rtp+=~/.vim/bundle/vader.vim
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
EOF
) +Vader! tests/*.vader && echo Success || exit 1

# Run through variations of user preferences that might mess with us.
echo
echo "Ignore case enabled"
echo "-------------------"
vim -Nu <(cat <<EOF
filetype off
set rtp+=~/.vim/bundle/vader.vim
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
set ignorecase
EOF
) +Vader! tests/*.vader && echo Success || exit 1

echo
echo "no hyphen in iskeyword"
echo "----------------------"
vim -Nu <(cat <<EOF
filetype off
set rtp+=~/.vim/bundle/vader.vim
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
set iskeyword+=-
EOF
) +Vader! tests/*.vader && echo Success || exit 1

echo
echo "All tests are passing."
echo
