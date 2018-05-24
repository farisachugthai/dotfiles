augroup jedi
    autocmd! 
    autocmd VimEnter,BufNewFile,BufReadPost * if !empty(maparg('<Leader>n', 'call jedi#usages()<CR>))' | unmap <buffer> '<Leader>n'| endif augroup END
