# Scratchpad

This is going to serve largely as a place to leave myself reminders about Nvim
performance, results of profiling, changes I need to make, Vimscript I
[begrudingly] want to learn and other things.

Gonna house modifications I don't want to delete or traverse a git history for.

# TODO

first things first let's jot down some thoughts.
fix ntree mappings
get a better handle of jedi flake ale and pyls before adding anything else.
already a  pretty sizeable stack of stuff
fix up skeleton.py so it has some pep257 compliant example docstrings. if they
had pep484 type hints too thatd be sweet.

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


### Vimscript making syscalls

    " normal PlugInstall +UpdateRemotePlugins :clo
    " Above didn't work. Unsure why.


Was originally after the sys curl  call to download vimplug and above the endif

## vim-plug

got rid of like 6 or 7 very heavy plugins and also ditched this
immediately after call plug#end

" load deop and ultisnips after entering insert mode. note plugin confs for
" loading deop after first enter. redundant?
" augroup load_us_deop
"     autocmd!
"     autocmd InsertEnter * call plug#load('ultisnips', 'deoplete'
"                 \| autocmd! load_us_deop)
" augroup END



Plugins to shave off
i desperately need nvim moving faster


## Lightline

" Lightline: {{{
let g:lightline = {
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ }


function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline.colorscheme = 'seoul256'
" }}}


## Tagbar

" Tagbar:
" https://github.com/majutsushi/tagbar
" Termux uses Universal Ctags and apparently tagbar doesn't like that.
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 0  " do not automatically jump to tagbar when opened
let g:tagbar_autoclose = 1  " when you jump to a tag close tagbar
" autocmd FileType python nested :TagbarOpen  " open tagbar when you see .py
" autocmd BufWinLeave python nested :TagbarClose
let g:tagbar_show_linenumbers = 1



## NERDTree Tabs
I feel like airline could handle this by itself
" NERDTree Tabs:
let g:nerdtree_tabs_no_startup_for_diff = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_startup_cd = 1


## compiler fxn

" Compiler Func: {{{
" All in one compiler. Gonna rewrite to make my own
" map <F5> :call CompileRunGcc()<CR>
" func! CompileRunGcc()
"     exec "w"
"     if &filetype == 'c'
"         exec "!g++ % -o %<"
"         exec "!time ./%<"
"     elseif &filetype == 'cpp'
"         exec "!g++ % -o %<"
"         exec "!time ./%<"
"     elseif &filetype == 'java'
"         exec "!javac %"
"         exec "!time java %<"
"     elseif &filetype == 'sh'
"         :!time bash %
"     elseif &filetype == 'python'
"         exec "!time python2.7 %"
"     elseif &filetype == 'html'
"         exec "!firefox % &"
"     elseif &filetype == 'go'
"         exec "!go build %<"
"         exec "!time go run %"
"     elseif &filetype == 'mkd'
"         exec "!~/.vim/markdown.pl % > %.html &"
"         exec "!firefox %.html &"
"     endif
" endfunc
" }}}
