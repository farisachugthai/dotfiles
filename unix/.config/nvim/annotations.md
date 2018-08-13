# Scratchpad

## todo

nvim crashes on some :Man commands.
Need to figure out if its consistent when I have nvim open and don't care if it
crashes

## Plugins

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


## compiler fxn

Now out of curiosity would this go in .config/nvim/compilers?

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
Undodir is in the wrong spot.

- 'viminfo' includes "!"
- 'wildmenu' is set by default



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


## Fun with clipboards


" fun trick from he provider. Before i uncomment, how do i check if I'm in
" tmux? lol just run py3 import vim, os; py3 if os.environ.get('TMUX'):
" let g:clipboard = {
"           \   'name': 'myClipboard',
"           \   'copy': {
"           \      '+': 'tmux load-buffer -',
"           \      '*': 'tmux load-buffer -',
"           \    },
"           \   'paste': {
"           \      '+': 'tmux save-buffer -',
"           \      '*': 'tmux save-buffer -',
"           \   },
"           \   'cache_enabled': 1,
"           \ }

" If `cache_enabled` is |TRUE| then when a selection is copied, Nvim will cache
" the selection until the copy command process dies. When pasting, if the copy
" process has not died, the cached selection is applied.
