# Scratchpad

This is going to serve largely as a place to leave myself reminders about Nvim
performance, results of profiling, changes I need to make, Vimscript I
[begrudingly] want to learn and other things.

## Jedi Function

Not really ready to do away with this completely.
If I ever set Jedi to not start at startup, then I think a StartJedi() func
would be great.

" Adapted largely from:
" https://github.com/tony/vim-config-framework/blob/2018-06-09/plugins.settings/contrib/jedi.vim
function! StartJedi()
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0

    let g:jedi#use_splits_not_buffers = 'right'
    let g:jedi#documentation_command = '<leader>h'
    let g:jedi#usages_command = '<leader>u'
    let g:jedi#completions_command = '<C-N>'
    " Improve performance by setting this to 0:
    " https://github.com/davidhalter/jedi-vim/issues/163#issuecomment-73343003
    let g:jedi#show_call_signatures = 2

    augroup PreviewOnBottom
        autocmd InsertEnter * set splitbelow
        autocmd InsertLeave * set splitbelow!
    augroup END
endfunction

" call PlugOnLoad('jedi-vim', 'call StartJedi()')       " code doesn't work


I feel like just running :call StartJedi() should work though...
