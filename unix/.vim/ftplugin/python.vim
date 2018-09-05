" python.vim
" Maintainer: Faris Chugthai

" Guard that should be at the top of all ftplugins
if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let g:python_highlight_all = 1

" Ale:
" Before we get too complicated let's just get rid of the necessaries.
" Actually those fixers are probably ones I can set globally
" they are
" let b:ale_fixers = [ 'remove_trailing_lines', 'trim_whitespace' ]


let g:ale_python_flake8_options = '--config ~/.config/flake8'


" The external program vim uses for gg=G can be configured
setlocal equalprg=yapf

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Highlight characters after 120 chars
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

" Python Executables: {{{ 3
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
    if isdirectory("$HOME/virtualenvs")
        let g:ale_virtualenv_dir_names+="virtualenvs"
    endif
endif
" }}}

" Jedi:
let g:jedi#completions_command = "<C-N>"
let g:jedi#smart_auto_mappings = 1          " if you see 'from' immediately create
let g:jedi#popup_on_dot = 1                 " 'import'. slows things down too much
let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
let g:jedi#completions_enabled = 1          " we all know they based their work off you anyway
let g:jedi#show_call_signatures = 100
let g:jedi#force_py_version = 3

let &cpo = s:keepcpo
unlet s:keepcpo
