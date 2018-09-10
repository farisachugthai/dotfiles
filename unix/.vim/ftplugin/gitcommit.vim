" Taken from:
" https://github.com/thoughtbot/dotfiles/blob/master/vim/ftplugin/gitcommit.vim

" Automatically wrap at 72 characters and spell check commit messages
setlocal textwidth=72
setlocal spell

" keep the first line of a git commit 50 char long and everything after 72.
setlocal colorcolumn=50,73

" and if you want a hint at the required hl-ColorColumn syntax.
"hi ColorColumn ctermbg=lightgrey guibg=lightgrey
