" python.vim
" Maintainer: Faris Chugthai
"
" TODO: Set something to completefunc. But what?

setlocal foldlevelstart=1
" All: {{{ 1

" Guard that should be at the top of all ftplugins: {{{ 2
if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim
" }}}

" Options: {{{ 2

" Pep Indenting
setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let b:python_highlight_all = 1

" The external program vim uses for gg=G can be configured
setlocal equalprg=yapf
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
    " Termux settings

    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    " Something like if has($VIRTUAL_ENV) evaluates to 0 but we could also
    " try something like that
    if executable('/home/faris/miniconda3/envs/neovim/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim/bin/python'
    endif

    " as a last resort we should just assign the fucking system py3 ya know
    " so i think this is gonna need to be a series of try/catches because the
    " the 'fallback' of /usr/bin/python3 should only run if nothing else could
    " this is the moment where defining if os == Android | s:uroot=$PREFIX |
    " elif { and btw is it elseif in vimL } os == Linux | s:uroot=/usr is
    " gonna be necessary ughhh
    " gonna need to check out syntax for how to write these expressions.
    " TODO:
    " 1. how to expand environment variables. because the first block in the try
    " catch should be if $VIRTUAL_ENV. then we'll need to expand $PREFIX.
    " 2. how to check which OS we're on.
    " 3. check if the syntax is elif or elseif.
    " 4. try catch syntax.
    " 5. if we define a var in vimrc, and ftplugin sources it, is the var
    " still there? how do namespaces work? fuck this is really complicated.

endif

" }}}

" Plugins: {{{ 2

" Jedi: {{{ 3
let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
let g:jedi#completions_command = '<C-N>'
let g:jedi#documentation_command = '<leader>h'
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures_delay = 100  " wait 100ms instead of 500 to show CS
" }}}

" Ale: {{{ 3
" should i check if there's a config file in the current dir or in the project
" dir? hmmmmm
let b:ale_python_flake8_options = '--config ~/.config/flake8'
if isdirectory("$HOME/virtualenvs")
    let g:ale_virtualenv_dir_names+="virtualenvs"
    " so i found this in the help docs
    " wth is the syntax for the path? have i been doing this all wrong?
    " call mkdir($HOME . \"/tmp/foo/bar", \"p", 0700)
endif
" }}}

" Python Language Server: {{{ 3
" ftplugins are supposed to be buffer local plugins right?
let b:LanguageClient_serverCommands = { 'python': ['pyls'] }
let b:LanguageClient_autoStart = 1
let b:LanguageClient_selectionUI = 'fzf'
" the mapping below clobbers your run *.py mapping
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient_textDocument_hover()<CR>
nnoremap gd :call LanguageClient_textDocument_definition()<CR>
" }}}

" }}}

" Guard at the end of all ftplugins: {{{ 2
let &cpo = s:keepcpo
unlet s:keepcpo
" }}}

" }}}
