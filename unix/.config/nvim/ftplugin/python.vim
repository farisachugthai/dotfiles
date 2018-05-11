" In /usr/share/nvim/python.vim pydoc is used for keyword prg.
" However if the system python==3, we need pydoc 3.

let g:pydoc_executable=pydoc3
setlocal keywordprg=pydoc3
