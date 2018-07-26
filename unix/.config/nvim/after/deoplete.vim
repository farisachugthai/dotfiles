
" Deoplete: {{{
"" disable autocomplete by default
let g:deoplete_disable_auto_complete = 1
let g:deoplete#enable_smart_case = 1

"" Close the autocompleter when we leave insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

set completeopt+=noinsert                    "" Autoselect feature

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

"" Do not complete too short words
call deoplete#custom#source(
\ 'dictionary', 'min_pattern_length', 4)

" Collect keywords from buffer path not directory Nvim was launched from
call deoplete#custom#source(
\ 'file', 'enable_buffer_path', 'True')

autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']
" }}}
