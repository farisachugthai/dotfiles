# Scratchpad

## todo

nvim crashes on some :Man commands.
Need to figure out if its consistent when I have nvim open and don't care if it
crashes

## Plugins

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
