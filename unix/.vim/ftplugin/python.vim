" python.vim

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let g:python_highlight_all = 1


" Before we get too complicated let's just get rid of the necessaries.
" Actually those fixers are probably ones I can set globally
" let b:ale_fixers = [ 'remove_trailing_lines', 'trim_whitespace' ]

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Jedi:
let g:jedi#smart_auto_mappings = 0
" let g:jedi#popup_on_dot = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#completions_enabled = 0
" let g:jedi#completions_command = '<C-N>'but if WAS enabled....
let g:jedi#documentation_command = '<leader>h'
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures_delay = 50  " wait 50ms instead of 500 to show CS

" Pyls:
" TODO: Properly handle env vars to cut this code in half
if has('python3')

    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    " Something like if has($VIRTUAL_ENV) evaluates to 0 but we could also
    " try something like that
    if executable('/home/faris/miniconda3/envs/neovim/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim/bin/python'
    endif

    " as a last resort we should just assign the fucking system py3 ya know

endif


if isdirectory("$HOME/virtualenvs")
    let g:ale_virtualenv_dir_names+="virtualenvs"
    " so i found this in the help docs
    " wth is the syntax for the path? have i been doing this all wrong?
    " call mkdir($HOME . \"/tmp/foo/bar", \"p", 0700)
endif
" }}}

" Language Servers:
" ftplugins are supposed to be buffer local plugins right?
let b:LanguageClient_serverCommands = { 'python': ['pyls'] }
let b:LanguageClient_autoStart = 1
let b:LanguageClient_selectionUI = 'fzf'
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient_textDocument_hover()<CR>
nnoremap gd :call LanguageClient_textDocument_definition()<CR>
setlocal omnifunc=LanguageClient#complete
setlocal completefunc=LanguageClient#complete



" First time: try finding pydoc
if !exists('g:pydoc_executable')
    if executable('pydoc')
        let g:pydoc_executable = 1
    else
        let g:pydoc_executable = 0
    endif
endif
" If pydoc was found use it for keywordprg.
if g:pydoc_executable
    setlocal keywordprg=pydoc
endif

let &cpo = s:keepcpo
unlet s:keepcpo

" Below is the global ftplugin for python for context
"
" Directly below are things I wanna incorporate
"
" setlocal omnifunc=pythoncomplete#Complete
" if has('python3')
"        setlocal omnifunc=python3complete#Complete
" endif

" set wildignore+=*.pyc

" let b:next_toplevel='\v%$\|^(class\|def\|async def)>'
" let b:prev_toplevel='\v^(class\|def\|async def)>'
" let b:next_endtoplevel='\v%$\|\S.*\n+(def\|class)'
" let b:prev_endtoplevel='\v\S.*\n+(def\|class)'
" let b:next='\v%$\|^\s*(class\|def\|async def)>'
" let b:prev='\v^\s*(class\|def\|async def)>'
" let b:next_end='\v\S\n*(%$\|^(\s*\n*)*(class\|def\|async def)\|^\S)'
" let b:prev_end='\v\S\n*(^(\s*\n*)*(class\|def\|async def)\|^\S)'



" I feel like i would learn word text objects so much faster if i knew
" thethings that vim counted as a text object in the language i care about ya
" know
"
"btw be careful with these i had to demolish the quotes to make sure that they
" were commented out. just go to /usr/share/nvim/runtime/ftplugin/python.vim







" " execute 'nnoremap <silent> <buffer> ]] :call <SID>Python_jump('n', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" " execute 'nnoremap <silent> <buffer> [[ :call <SID>Python_jump('n', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" " execute 'nnoremap <silent> <buffer> ][ :call <SID>Python_jump('n', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [] :call <SID>Python_jump('n', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> ]m :call <SID>Python_jump('n', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [m :call <SID>Python_jump('n', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> ]M :call <SID>Python_jump('n', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [M :call <SID>Python_jump('n', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'

" ' execute 'onoremap <silent> <buffer> ]] :call <SID>Python_jump('o', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [[ :call <SID>Python_jump('o', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ][ :call <SID>Python_jump('o', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [] :call <SID>Python_jump('o', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ]m :call <SID>Python_jump('o', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [m :call <SID>Python_jump('o', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ]M :call <SID>Python_jump('o', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [M :call <SID>Python_jump('o', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'

" ' execute 'xnoremap <silent> <buffer> ]] :call <SID>Python_jump('x', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [[ :call <SID>Python_jump('x', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ][ :call <SID>Python_jump('x', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [] :call <SID>Python_jump('x', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ]m :call <SID>Python_jump('x', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [m :call <SID>Python_jump('x', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ]M :call <SID>Python_jump('x', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [M :call <SID>Python_jump('x', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'


" So can we incorporate pydoc3?

" First time: try finding pydoc
" if !exists('g:pydoc_executable')
"     if executable('pydoc')
"         let g:pydoc_executable = 1
"     else
"         let g:pydoc_executable = 0
"     endif
" endif
" If pydoc was found use it for keywordprg.
" if g:pydoc_executable
"     setlocal keywordprg=pydoc
" endif

" let &cpo = s:keepcpo
" unlet s:keepcpo





" " Vim filetype plugin file
" " Language:	python
" " Maintainer:	Tom Picton <tom@tompicton.co.uk>
" " Previous Maintainer: James Sully <sullyj3@gmail.com>
" " Previous Maintainer: Johannes Zellner <johannes@zellner.org>
" " Last Change:	Sun, 15 April 2018
" " https://github.com/tpict/vim-ftplugin-python

" if exists("b:did_ftplugin") | finish | endif
" let b:did_ftplugin = 1
" let s:keepcpo= &cpo
" set cpo&vim

" setlocal cinkeys-=0#
" setlocal indentkeys-=0#
" setlocal include=^\\s*\\(from\\\|import\\)

" " For imports with leading .., append / and replace additional .s with ../
" let b:grandparent_match = '^\(.\.\)\(\.*\)'
" let b:grandparent_sub = '\=submatch(1)."/".repeat("../",strlen(submatch(2)))'

" " For imports with a single leading ., replace it with ./
" let b:parent_match = '^\.\(\.\)\@!'
" let b:parent_sub = './'

" " Replace any . sandwiched between word characters with /
" let b:child_match = '\(\w\)\.\(\w\)'
" let b:child_sub = '\1/\2'

" setlocal includeexpr=substitute(substitute(substitute(
"       \v:fname,
"       \b:grandparent_match,b:grandparent_sub,''),
"       \b:parent_match,b:parent_sub,''),
"       \b:child_match,b:child_sub,'g')

" setlocal suffixesadd=.py
" setlocal comments=b:#,fb:-
" setlocal commentstring=#\ %s

" setlocal omnifunc=pythoncomplete#Complete
" if has('python3')
"        setlocal omnifunc=python3complete#Complete
" endif

" set wildignore+=*.pyc

" let b:next_toplevel='\v%$\|^(class\|def\|async def)>'
" let b:prev_toplevel='\v^(class\|def\|async def)>'
" let b:next_endtoplevel='\v%$\|\S.*\n+(def\|class)'
" let b:prev_endtoplevel='\v\S.*\n+(def\|class)'
" let b:next='\v%$\|^\s*(class\|def\|async def)>'
" let b:prev='\v^\s*(class\|def\|async def)>'
" let b:next_end='\v\S\n*(%$\|^(\s*\n*)*(class\|def\|async def)\|^\S)'
" let b:prev_end='\v\S\n*(^(\s*\n*)*(class\|def\|async def)\|^\S)'

" ' i can't keep commenting and toggling the rest of this. i mean it's
" ' interesting code but ugh.
" ' execute 'nnoremap <silent> <buffer> ]] :call <SID>Python_jump('n', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [[ :call <SID>Python_jump('n', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> ][ :call <SID>Python_jump('n', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [] :call <SID>Python_jump('n', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> ]m :call <SID>Python_jump('n', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [m :call <SID>Python_jump('n', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> ]M :call <SID>Python_jump('n', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'nnoremap <silent> <buffer> [M :call <SID>Python_jump('n', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'

" ' execute 'onoremap <silent> <buffer> ]] :call <SID>Python_jump('o', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [[ :call <SID>Python_jump('o', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ][ :call <SID>Python_jump('o', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [] :call <SID>Python_jump('o', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ]m :call <SID>Python_jump('o', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [m :call <SID>Python_jump('o', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> ]M :call <SID>Python_jump('o', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'onoremap <silent> <buffer> [M :call <SID>Python_jump('o', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'

" ' execute 'xnoremap <silent> <buffer> ]] :call <SID>Python_jump('x', ''. b:next_toplevel.'', 'W', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [[ :call <SID>Python_jump('x', ''. b:prev_toplevel.'', 'Wb', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ][ :call <SID>Python_jump('x', ''. b:next_endtoplevel.'', 'W', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [] :call <SID>Python_jump('x', ''. b:prev_endtoplevel.'', 'Wb', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ]m :call <SID>Python_jump('x', ''. b:next.'', 'W', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [m :call <SID>Python_jump('x', ''. b:prev.'', 'Wb', v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> ]M :call <SID>Python_jump('x', ''. b:next_end.'', 'W', 0, v:count1)<cr>'
" ' execute 'xnoremap <silent> <buffer> [M :call <SID>Python_jump('x', ''. b:prev_end.'', 'Wb', 0, v:count1)<cr>'

"   fun! <SID>Python_jump(mode, motion, flags, count, ...) range
"       let l:startofline = (a:0 >= 1) ? a:1 : 1

"       if a:mode == 'x'
"           normal! gv
"       endif

"       if l:startofline == 1
"           normal! 0
"       endif

"       let cnt = a:count
"       mark '
"       while cnt > 0
"           call search(a:motion, a:flags)
"           let cnt = cnt - 1
"       endwhile

"       if l:startofline == 1
"           normal! ^
"       endif
"   endfun
" endif

" if has("browsefilter") && !exists("b:browsefilter")
"     let b:browsefilter = 'Python Files (*.py)\t*.py\n" .
"                 \ 'All Files (*.*)\t*.*\n"
" endif

" if !exists("g:python_recommended_style") || g:python_recommended_style != 0
"     " As suggested by PEP8.
"     setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
" endif
