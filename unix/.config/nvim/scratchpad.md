# Scratchpad

This is going to serve largely as a place to leave myself reminders about Nvim
performance, results of profiling, changes I need to make, Vimscript I
[begrudingly] want to learn and other things.

Gonna house modifications I don't want to delete or traverse a git history for.

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

07/15/18

dumping deoplete

" Deoplete: {{{
"" disable autocomplete by default
let g:deoplete_disable_auto_complete = 1
let g:deoplete#enable_smart_case = 1

"" Close the autocompleter when we leave insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" Autoselect feature
set completeopt+=noinsert

let g:deoplete#enable_at_startup = 0 " don't start right away let everything load
autocmd InsertEnter * call deoplete#enable()    " if i enter insert mode go for it
call deoplete#custom#option('smart_case', v:true)

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

"" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

"" Close the autocompleter when we leave insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
"Note: You must enable
"|deoplete-source-attribute-is_debug_enabled| to debug the
"sources.
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)

"" Do not complete too short words
call deoplete#custom#source(
\ 'dictionary', 'min_pattern_length', 4)

" Collect keywords from buffer path not directory Nvim was launched from
call deoplete#custom#source(
\ 'file', 'enable_buffer_path', 'True')

" Setting up the omnifuncs
set omnifunc=LanguageClient#complete

autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']
" }}}


As stupid as this sounds, if pyls is registering as an rplugin for nvim....
trying running the pyls executable from your shell. then in a separate window
nvim +UpdateRemotePlugins

" " Lightline: {{{
" let g:lightline = {
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ],
"     \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"     \ },
"     \ 'component_function': {
"     \   'gitbranch': 'fugitive#head',
"     \   'filetype': 'MyFiletype',
"     \   'fileformat': 'MyFileformat',
"     \ },
"     \ }


" function! MyFiletype()
"     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endfunction


" function! MyFileformat()
"     return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endfunction

" let g:lightline.colorscheme = 'seoul256'
" " }}}

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


" unnecessary fzf func

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

if you put this back make sure the following goes in let g:fzf_action

  \ 'ctrl-q': function('s:build_quickfix_list'),



" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_in_gutter = 1



Unnecessary ale function

" function! LinterStatus() abort
"   let l:counts = ale#statusline#Count(bufnr(''))

"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors

"   return l:counts.total == 0 ? '' : printf( '%dW %dE', l:all_non_errors, l:all_errors )
" endfunction

# DEBUGGING DEOPLETE


" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
"Note: You must enable
"|deoplete-source-attribute-is_debug_enabled| to debug the
"sources.
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)
