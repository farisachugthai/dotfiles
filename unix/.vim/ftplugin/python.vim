" python.vim
" Maintainer: Faris Chugthai

" TODO: Set something to completefunc. But what?

setlocal foldlevelstart=1
" All: {{{ 1

" Guard that should be at the top of all ftplugins: {{{ 2
if exists('b:did_ftplugin')
    finish
endif

let b:did_ftplugin = 1
let s:keepcpo= &cpoptions
set cpoptions&vim
" }}}

" Options: {{{ 2

" Pep Indenting
setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let b:python_highlight_all = 1

" The external program vim uses for gg=G can be configured
setlocal equalprg=yapf

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
" }}}

" Autocommands: {{{ 2
" Highlight characters after 120 chars
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END
" }}}

" Python Executables: {{{ 2
"
"     " Something like if has($VIRTUAL_ENV) evaluates to 0 but we could also
"     " try something like that
"
if has('python3')
    " Termux settings
    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif
    " Desktop
    if executable('/home/faris/miniconda3/envs/neovim_vscode/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim_vscode/bin/python'
    endif
    " Let nvim/ale check out the virtualenvs and source the right files
    if isdirectory('$HOME/virtualenvs')
        let g:ale_virtualenv_dir_names+='virtualenvs'
    endif
endif
" }}}

" Plugins: {{{ 2

" Jedi: {{{ 3
let g:jedi#completions_command = '<C-N>'
let g:jedi#smart_auto_mappings = 1          " if you see 'from' immediately create
let g:jedi#popup_on_dot = 1                 " 'import'. slows things down too much
let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
let g:jedi#completions_enabled = 1          " we all know they based their work off you anyway
let g:jedi#show_call_signatures = 100
let g:jedi#force_py_version = 3
" }}}

" Ale: {{{ 3
let g:ale_python_flake8_options = '--config ~/.config/flake8'
" }}}

" }}}

" Guard at the end of all ftplugins: {{{ 2
let &cpoptions = s:keepcpo
unlet s:keepcpo
" }}}

" }}}
