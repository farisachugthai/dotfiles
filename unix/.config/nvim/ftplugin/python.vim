" python.vim

" Even though these are globally set, the tabs still got messed up
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" For use with AleFix...also all supported linters
" let b:ale_fixers = {'python': ['flake8', 'autopep', 'pyls', 'mypy', 'pycodestyle', 'pyflakes', 'pylint']}

let b:ale_fixers = {'python3': ['flake8', 'pyls', 'pylint']}


" Cinwords =
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Highlight characters after 120 chars
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END
