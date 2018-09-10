" python.vim
" Maintainer: Faris Chugthai

" All: {{{ 1

" Nvim_OS: {{{ 2

if has('nvim')
    let s:vimd = '~/.config/nvim'
    let s:vimrc = '~/.config/nvim/init.vim'
else
    let s:vimd = '~/.vim'
    let s:vimrc = '~/.vim/vimrc'
endif

if exists('$PREFIX')
    let s:usrd = '$PREFIX'     " might need to expand on use
    let s:OS= 'Android'
else
    let s:usrd = '/usr'
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

if has('python3')
    setlocal keywordprg=pydoc3
endif
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
        let g:python3_host_prog = expand('$CONDA_PYTHON_EXE')

    " otherwise break up termux and linux
    elseif exists('$PREFIX')
        " and just use the system python
        let g:python3_host_prog = '$PREFIX/bin/python'
    else
        let g:python3_host_prog = '/usr/bin/python3'
    endif
endif

" }}}

" Plugins: {{{ 2

" Jedi: {{{ 3
let g:jedi#use_tabs_not_buffers = 1             " easy to maintain workspaces
" let g:jedi#completions_command = '<C-N>'
let g:jedi#documentation_command = '<leader>h'
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures_delay = 100     " wait 100ms instead of 500 to show CS
let g:jedi#smart_auto_mappings = 0              " must be set
let g:jedi#force_py_version = 3
" }}}

" ALE: {{{ 3
let b:ale_linters = ['flake8', 'pyls']
let b:ale_linters_ignore = [ 'pylint' ]
" should i check if there's a config file in the current dir or in the project
let b:ale_python_flake8_options = '--config ~/.config/flake8'
" Mypy is slow and we have other linters to check syntax
let b:ale_python_mypy_ignore_invalid_syntax = 1

if isdirectory('$HOME/virtualenvs')
    let g:ale_virtualenv_dir_names += 'virtualenvs'
endif
" }}}

" Python Language Server: {{{ 3
" ftplugins are supposed to be buffer local plugins right?
let b:LanguageClient_serverCommands = { 'python': ['pyls'] }
let b:LanguageClient_autoStart = 1
let b:LanguageClient_selectionUI = 'fzf'
" the mapping below clobbers your run *.py mapping
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" this isn't pulling up docs like i want
" nnoremap K :call LanguageClient_textDocument_hover()<CR>
nnoremap gd :call LanguageClient_textDocument_definition()<CR>
" }}}

" }}}

" }}}
