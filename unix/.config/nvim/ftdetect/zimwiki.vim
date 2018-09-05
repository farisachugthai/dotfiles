" Language: ZimWiki
" Maintainer: Joan Rivera <joan.manuel.rivera+dev@gmail.com>
" URL: https://github.com/joanrivera/vim-zimwiki-syntax
" License: MIT

function! s:DetectZimWiki()
    if getline(1) =~ 'Content-Type: text/x-zim-wiki'
        set filetype=zimwiki
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectZimWiki()
