" Markdown ftplugin
" Maintainer: Faris Chugthai

" TODO: Fix the way that '_' is highlighted in md

" Enable spellchecking. TODO: Need to fix spellchecking
" setlocal spell

" Automatically wrap at 79 characters after whitespace
setlocal textwidth=79

setlocal colorcolumn=80

" Fix tabs so that we can have ordered lists render properly
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Got rid of the guards at the top and bottom because we actually
" need both my ftplugin and the runtime builtin to execute
