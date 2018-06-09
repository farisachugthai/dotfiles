" In /usr/share/nvim/python.vim pydoc is used for keyword prg.
" However if the system python==3, we need pydoc 3.

" this isn't working idk why
" let g:pydoc_executable=pydoc3
" setlocal keywordprg=pydoc3
"
" more importantly ALL MY TABS ARE MESSED UP
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" For use with AleFix

let b:ale_fixers = {'python': ['flake8', 'autopep', 'pyls', 'mypy', 'pycodestyle', 'pyflakes', 'pylint']}
