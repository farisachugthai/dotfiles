# Scratchpad

This is going to serve largely as a place to leave myself reminders about Nvim
performance, results of profiling, changes I need to make, Vimscript I
[begrudingly] want to learn and other things.

Gonna house modifications I don't want to delete or traverse a git history for.

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


## Deoplete


" Termux's hardcoded python interpreter
    " if executable('$PREFIX/bin/python')
        " let g:python3_host_prog = '$PREFIX/bin/python'
    " endif
    " evals to 0 outside venv on termux

    " should probably put some logic somewhere to ensure that this is working
    " correctly, that i activated conda, i'm in the right environment etc




" Under the assmption we're in the right virtualenv
" Might need to do a try catch and cathc with a list of providers
if isdirectory('$HOME/miniconda/envs/neovim_vscode/bin')
    let g:python3_host_prog = '$HOME/miniconda/envs/neovim_vscode/bin/python'
else
    let g:python3_host_prog = '$HOME/virtualenvs/nvim/bin/python3'
endif




" Remove this if you'd like to use fuzzy search
"call deoplete#custom#source(
"\ 'dictionary', 'matchers', ['matcher_head'])

"" If dictionary is already sorted, no need to sort it again.
"call deoplete#custom#source(
"\ 'dictionary', 'sorters', [])


## VimScript Struggles

" don't know what i'm doing wrong here but only recently started learning viml
"if g:textwidth == 0             " Basically saying is it ever unset? Set it 100
    "setlocal colorcolumn = 100
"elseif                          " how do we check that a variable is set to a non-zero integer?
    "setlocal colorcolumn+=1
"else                            " Don't actually think this part does anything?
    "setlocal colorcolumn=+1
"endif
