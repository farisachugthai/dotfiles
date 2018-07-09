" python.vim

" Even though these are globally set, ths tabs still got messed up
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" For use with AleFix

let b:ale_fixers = {'python': ['flake8', 'autopep', 'pyls', 'mypy', 'pycodestyle', 'pyflakes', 'pylint']}

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
