# Annotations

## TODO:

For 08-12-18

Add in i3.vim into syntax and ftdetect [check them out from termux branch]

use curl to get juneguun's vim profiling script, then rework it so it works for
you

  - also that'll allow you to check that the curlrc you checked out from
    termux works

then roll through init.vim and get yours to generally kinda match termux's.
don't sweat it too much if it really isn't that similar.

then go to gdrive and make the mods that you wrote down in there.

and then possibly use :Glog or something to ensure that you didn't wipe out any
historical changes because there's a bunch of shit missing tmk.

Just way easier to fix it here than on my phone.


## Plugins
=======

### Jedi Function

Not really ready to do away with this completely.

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


### More options

{ Still kinda related to deoplete / pyls}

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

### lightline

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


" function! MyFiletype()
"     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endfunction


" function! MyFileformat()
"     return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endfunction

" let g:lightline.colorscheme = 'seoul256'
" " }}}

## functions

### compilers

Now out of curiosity would this go in .config/nvim/compilers?

Compiler Func: {{{
All in one compiler. Gonna rewrite to make my own
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
}}}


### ALE


function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf( '%dW %dE', l:all_non_errors, l:all_errors )
endfunction


## Diff between nvim and vim

2. Defaults					            *nvim-defaults*

- Syntax highlighting is enabled by default
- ":filetype plugin indent on" is enabled by default

- 'autoindent' is set by default
- 'autoread' is set by default
- 'backspace' defaults to "indent,eol,start"
- 'backupdir' defaults to .,~/.local/share/nvim/backup (|xdg|)
- 'belloff' defaults to "all"
- 'complete' doesn't include "i"
- 'cscopeverbose' is enabled
- 'directory' defaults to ~/.local/share/nvim/swap// (|xdg|), auto-created
- 'display' defaults to "lastline,msgsep"
- 'fillchars' defaults (in effect) to "vert:│,fold:·"
- 'formatoptions' defaults to "tcqj"
- 'history' defaults to 10000 (the maximum)
- 'hlsearch' is set by default
- 'incsearch' is set by default
- 'langnoremap' is enabled by default
- 'langremap' is disabled by default
- 'laststatus' defaults to 2 (statusline is always shown)
- 'listchars' defaults to "tab:> ,trail:-,nbsp:+"
- 'nocompatible' is always set
- 'nrformats' defaults to "bin,hex"
- 'ruler' is set by default
- 'sessionoptions' doesn't include "options"
- 'showcmd' is set by default
- 'sidescroll' defaults to 1
- 'smarttab' is set by default
- 'tabpagemax' defaults to 50
- 'tags' defaults to "./tags;,tags"
- 'ttyfast' is always set


**- 'undodir' defaults to ~/.local/share/nvim/undo (|xdg|), auto-created**
Undodir is in the wrong spkt.

- 'viminfo' includes "!"
- 'wildmenu' is set by default



## VimScript Struggles

" don't know what i'm doing wrong here but only recently started learning viml
if g:textwidth == 0             " Basically saying is it ever unset? Set it 100
   "setlocal colorcolumn = 100
elseif                          " how do we check that a variable is set to a non-zero integer?
   "setlocal colorcolumn+=1
else                            " Don't actually think this part does anything?
   "setlocal colorcolumn=+1
endif

### Vimscript making syscalls

    " normal PlugInstall +UpdateRemotePlugins :clo
    " Above didn't work. Unsure why.

Was originally after the sys curl  call to download vimplug and above the endif


## Fun with clipboards


fun trick from he provider. Before i uncomment, how do i check if I'm in
tmux? lol just run py3 import vim, os; py3 if os.environ.get('TMUX'):
let g:clipboard = {
          \   'name': 'myClipboard',
          \   'copy': {
          \      '+': 'tmux load-buffer -',
          \      '*': 'tmux load-buffer -',
          \    },
          \   'paste': {
          \      '+': 'tmux save-buffer -',
          \      '*': 'tmux save-buffer -',
          \   },
          \   'cache_enabled': 1,
          \ }

If `cache_enabled` is |TRUE| then when a selection is copied, Nvim will cache
the selection until the copy command process dies. When pasting, if the copy
process has not died, the cached selection is applied.
