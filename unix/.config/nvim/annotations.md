# Annotations

## runtime

so this feels like an actual problem

:scriptnames
on any filetype is indicating that the only files that are getting source from
~/.config/nvim are init.vim, autocorrect.vim, the ftdetect dir and if the ft matches something in
ftplugin then that file.

however, i have a file in after/ that isn't getting sourced?
none of my spell files.
idk i feel like this is a problem right?
:echo &rtp

okay so ~/.config/nvim/after and ~/.config/nvim are the only dirs in rtp and
packpath. so i guess that's cool but how do we properly use autoload?



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

echo $CONDA_PREFIX
/home/faris/miniconda3/envs/neovim

$ conda --version
conda 4.5.9

as of conda 4.5.9 the only indication of what conda env you're in seems to be
that env-var right there. the api changes constantly so don't bank on it;
however, that might be of use.

Actually i just tried running with nvim -i NONE [to disable the ShaDa file] and
it shaved over 30% off of my startuptime. dude nvim is getting so snappy!

## Plugins
=====================================================================

### Languange Client

Language Client can stay in ftplugin/python.vim for now but there's no reason
to limit it to that.

The only thing is the func LanguageClient_serverCommands()

But it's a simple dictionary. If you want, run a whole mess of loops checking
things you care about I.E. bash language server, pyls etc are executable.

if those loops return True, add it's name to the dictionary. then have the
server run the commands we feed to it

I'm not sure how I hadn't thought of this yet.


### lightline

honestly keep this around because airline is pretty heavy on termux

btw do the code blocks need viml or VimScript after the tick marks?

```viml
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
" }}}
```

## functions

### compilers

Now out of curiosity would this go in .config/nvim/compilers?

Compiler Func: {{{

All in one compiler. Gonna rewrite to make my own

```
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
```

}}}

### ALE

....what the hell is this?

```viml
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf( '%dW %dE', l:all_non_errors, l:all_errors )
endfunction
```

## VimScript Struggles

" don't know what i'm doing wrong here but only recently started learning viml
if g:textwidth == 0             " Basically saying is it ever unset? Set it 100
   "setlocal colorcolumn = 100
elseif                          " how do we check that a variable is set to a non-zero integer?
   "setlocal colorcolumn+=1
else                            " Don't actually think this part does anything?
   "setlocal colorcolumn=+1
endif

## Fun with clipboards

fun trick from he provider. Before i uncomment, how do i check if I'm in
tmux? actually learning how vim expands env vars is gonna be important.

```
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
```

If `cache_enabled` is |TRUE| then when a selection is copied, Nvim will cache
the selection until the copy command process dies. When pasting, if the copy
process has not died, the cached selection is applied.
