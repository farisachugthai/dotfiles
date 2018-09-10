" python.vim
" Maintainer: Faris Chugthai

setlocal foldlevelstart=1
" All: {{{ 1

" Wait does adding this mean I block one of either the built-in or mine?
" Guard that should be at the top of all ftplugins: {{{ 2
" if exists('b:did_ftplugin')
"     finish
" endif

" let b:did_ftplugin = 1
" let s:keepcpo= &cpoptions
" set cpoptions&vim
" }}}

" Nvim-OS: {{{ 2
" Gonna start seriously consolidating vimrc and init.vim this is so hard
" to maintain
" Let's setup all the global vars we need
" Wait am i assigning these vars correctly? man fuck vimscript

if has('nvim')
    let s:root = '~/.config/nvim'
    let s:conf = '~/.config/nvim/init.vim'
else
    let s:root = '~/.vim'
    let s:conf = '~/.vim/vimrc'
endif

if exists('$PREFIX')
    let s:usr_d = '$PREFIX'     " might need to expand on use
    let s:OS= 'Android'
else
    let s:usr_d = '/usr'
    let s:OS = 'Linux'
endif
" }}}

" Options: {{{ 2

" Pep Indenting
setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let b:python_highlight_all = 1

" The external program vim uses for gg=G can be configured
if executable('yapf')
    setlocal equalprg=yapf
endif

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" also let's know where the line needs to end visually but not invoke the
" linters to react.
set colorcolumn=79
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
if has('python3')
" if we have a venv start there
    if exists('$VIRTUAL_ENV')
        let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python'

    elseif exists('$CONDA_PYTHON_EXE')
        let g:python3_host_prog = $CONDA_PYTHON_EXE

    " otherwise break up termux and linux
    elseif exists('$PREFIX')
        " and just use the system python
        if executable('~/virtualenvs/neovim/bin/python3')
            let g:python3_host_prog = '~/virtualenvs/neovim/bin/python3'
        endif
    else
        if executable('~/miniconda3/envs/neovim_vscode/bin/python')
            let g:python3_host_prog = '~/miniconda3/envs/neovim_vscode/bin/python'
        endif
    endif
endif
" }}}

" Plugins: {{{ 2

" Jedi: {{{ 3
let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
let g:jedi#completions_command = '<C-N>'
let g:jedi#documentation_command = '<leader>h'
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures_delay = 100
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_py_version = 3
" }}}

" Ale: {{{ 3
let g:ale_python_flake8_options = '--config ~/.config/flake8'
if isdirectory('~/virtualenvs')
    let g:ale_virtualenv_dir_names+='virtualenvs'
endif
" }}}

" }}}

" Guard at the end of all ftplugins: {{{ 2
" let &cpoptions = s:keepcpo
" unlet s:keepcpo
" }}}

" }}}
