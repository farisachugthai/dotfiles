" python.vim

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let g:python_highlight_all = 1

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Jedi:
let g:jedi#smart_auto_mappings = 1
let g:jedi#popup_on_dot = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#completions_enabled = 1
let g:jedi#completions_command = '<C-N>'
let g:jedi#documentation_command = '<leader>h'
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures_delay = 50  " wait 50ms instead of 500 to show CS

" Python Executables:
" TODO: Properly handle env vars to cut this code in half
if has('python3')

    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    " Something like if has($VIRTUAL_ENV) evaluates to 0 but we could also
    " try something like that
    if executable('/home/faris/miniconda3/envs/neovim/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim/bin/python'
    endif

    " as a last resort we should just assign the fucking system py3 ya know

endif

" Ale:
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

" Language Servers:
" ftplugins are supposed to be buffer local plugins right?
let b:LanguageClient_serverCommands = { 'python': ['pyls'] }
let b:LanguageClient_autoStart = 1
let b:LanguageClient_selectionUI = 'fzf'
" the mapping below clobbers your run *.py mapping
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient_textDocument_hover()<CR>
nnoremap gd :call LanguageClient_textDocument_definition()<CR>

" it's a lovely plugin but of all the completeres why langclient???
" It's merely a vesse lto get deoplete working smoothly. Like at least go jedi
" or something....
" setlocal omnifunc=LanguageClient#complete
"setlocal completefunc=LanguageClient#complete



" First time: try finding pydoc
if !exists('g:pydoc_executable')
    if executable('pydoc')
        let g:pydoc_executable = 1
    else
        let g:pydoc_executable = 0
    endif
endif
" If pydoc was found use it for keywordprg.
if g:pydoc_executable
    setlocal keywordprg=pydoc
endif

let &cpo = s:keepcpo
unlet s:keepcpo
