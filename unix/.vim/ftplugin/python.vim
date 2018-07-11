" python.vim

" Even though these are globally set, ths tabs still got messed up
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" For use with AleFix

let b:ale_linters = {'python': ['flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylint', 'pyls', 'pyre']}

let b:ale_fixers = {'python': ['flake8', 'autopep', 'pyls', 'mypy', 'pycodestyle', 'pyflakes', 'pylint', 'remove_trailing_lines', 'trim_whitespace', 'yapf' ]}

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class


" Output of ALEInfo. I have all of those linters installed. There'd be
" literally no reason to have them all on but what's controlling who goes
" when?  I want pyls and pylint on.
" Current Filetype: python
" Available Linters: ['flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylint', 'pyls', 'pyre']
" Enabled Linters: ['flake8', 'mypy', 'pylint']
" Suggested Fixers:
" 'add_blank_lines_for_python_control_statements' - Add blank lines before control statements.
" 'autopep8' - Fix PEP8 issues with autopep8.
" 'black' - Fix PEP8 issues with black.
" 'isort' - Sort Python imports with isort.
" 'remove_trailing_lines' - Remove all blank lines at the end of a file.
" 'trim_whitespace' - Remove all trailing whitespace characters at the end of every line.
" 'yapf' - Fix Python files with yapf.
