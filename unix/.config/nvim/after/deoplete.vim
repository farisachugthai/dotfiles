" Deoplete: {{{
"" disable autocomplete by default
" let g:deoplete#enable_at_startup = 0 " don't start right away let everything load
" let g:deoplete_disable_auto_complete = 1
" let g:deoplete#enable_smart_case = 1

"" Close the autocompleter when we leave insert mode
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set completeopt+=noinsert                    " Autoselect feature

"" if i enter insert mode go for it
" autocmd InsertEnter * call deoplete#enable()
" call deoplete#custom#option('smart_case', v:true)

"" On <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"   Remember to get rid of the backslash at the beginning of the "\<CR>!
"   return deoplete#close_popup() . \"\<CR>"
" endfunction

"" Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

"" Close the autocompleter when we leave insert mode
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" Do not complete too short words
" call deoplete#custom#source(
" \ 'dictionary', 'min_pattern_length', 4)

" " Collect keywords from buffer path not directory Nvim was launched from
" call deoplete#custom#source(
" \ 'file', 'enable_buffer_path', 'True')

" autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

" load deop and ultisnips after entering insert mode. note plugin confs for
" loading deop after first enter. redundant?
" augroup load_us_deop
"     autocmd!
"     autocmd InsertEnter * call plug#load('ultisnips', 'deoplete'
"                 \| autocmd! load_us_deop)
" augroup END

" Remove this if you'd like to use fuzzy search
"call deoplete#custom#source(
"\ 'dictionary', 'matchers', ['matcher_head'])

"" If dictionary is already sorted, no need to sort it again.
"call deoplete#custom#source(
"\ 'dictionary', 'sorters', [])

"" Setting up the omnifuncs
" set omnifunc=LanguageClient#complete

" autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
"Note: You must enable
"|deoplete-source-attribute-is_debug_enabled| to debug the
"sources.
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)


" " }}}
