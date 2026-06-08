#!/bin/bash

set -eu

vim="$1"
rtp="$2"
shift 2

export HOME=/var/empty

REPO_TOP=$(git rev-parse --show-toplevel)
cd "${REPO_TOP}"

echo "Basic environment"
echo "-----------------"
$vim -Nu <(cat <<EOF
filetype off
set rtp+=$rtp
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
EOF
) +Vader! tests/*.vader

# Run through variations of user preferences that might mess with us.
echo
echo "Ignore case enabled"
echo "-------------------"
$vim -Nu <(cat <<EOF
filetype off
set rtp+=$rtp
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
set ignorecase
EOF
) +Vader! tests/*.vader

echo
echo "no hyphen in iskeyword"
echo "----------------------"
$vim -Nu <(cat <<EOF
filetype off
set rtp+=$rtp
set rtp+=./
filetype plugin indent on
syntax enable
autocmd filetype todo setlocal omnifunc=todo#Complete
set iskeyword+=-
EOF
) +Vader! tests/*.vader

echo
echo "All tests are passing."
echo
