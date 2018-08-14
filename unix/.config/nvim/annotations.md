# Annotations

## speeding nvim up

I've managed to shave off 3/4s of the time nvim takes to start up with a few
simple modifications

minimizing the number of times syntax coloring gets called by not enabling it
really at any point

LSP, deoplete even gruvbox activate it. so if you set a theme, make sure it's
the last line executed [or as close as possible]

so far jedi is responsible for around 1/3 of startup time but i'm not sure what
would need to change for that to stop. however, the python3 host not getting set
screws things up tremendously.

so outside of remembering to do that, it's maybe possible to utilize the conda
api to do a check yourself.

┌─[faris@parrot]─[~]
└──╼ $ echo $CONDA_PREFIX
/home/faris/miniconda3/envs/neovim

┌─[faris@parrot]─[~]
└──╼ $ conda --version
conda 4.5.9

as of conda 4.5.9 the only indication of what conda env you're in seems to be
that env-var right there. the api changes constantly so don't bank on it;
however, that might be of use.

Actually i just tried running with nvim -i NONE [to disable the ShaDa file] and
it shaved over 30% off of my startuptime. dude nvim is getting so snappy!

## Plugins
=====================================================================

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
