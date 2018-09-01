" python.vim
" Maintainer: Faris Chugthai

" Guard that should be at the top of all ftplugins
if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4
let g:python_highlight_all = 1

" Before we get too complicated let's just get rid of the necessaries.
" Actually those fixers are probably ones I can set globally
let b:ale_fixers = [ 'remove_trailing_lines', 'trim_whitespace' ]

setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Highlight characters after 120 chars
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

try
    setlocal omnifunc=LanguageClient#complete
    setlocal completefunc=LanguageClient#complete
catch
    setlocal omnifunc=python3complete#Complete
endtry

" maybe setup jedi completions idk?

" Put the below in if you wanna mark a color column at a certain textwidth
" could have 2 highlights one at 80 and 120 and make them different colors.
"

" *'colorcolumn'* *'cc'*
" 'colorcolumn' 'cc'	string	(default \"")
"             local to window
"             {not available when compiled without the |+syntax|
"             feature}
"     'colorcolumn' is a comma separated list of screen columns that are
"     highlighted with ColorColumn |hl-ColorColumn|.  Useful to align
"     text.  Will make screen redrawing slower.
"     The screen column can be an absolute number, or a number preceded with
"     '+' or '-', which is added to or subtracted from 'textwidth'. >

"         :set cc=+1  highlight column after 'textwidth'
"         :set cc=+1,+2,+3  highlight three columns after 'textwidth'
"         :hi ColorColumn ctermbg=lightgrey guibg=lightgrey
" <
"     When 'textwidth' is zero then the items with '-' and '+' are not used.
"     a maximum of 256 columns are highlighted.

" Uncomment to free up the main init.vim
" =============================================================

" Python Executables: {{{ 3
"
"     " Something like if has($VIRTUAL_ENV) evaluates to 0 but we could also
"     " try something like that
"
if has('python3')
    " Termux settings
    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif
    " Desktop
    if executable('/home/faris/miniconda3/envs/neovim_vscode/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim_vscode/bin/python'
    endif
    " Let nvim/ale check out the virtualenvs and source the right files
    if isdirectory("$HOME/virtualenvs")
        let g:ale_virtualenv_dir_names+="virtualenvs"
    endif
endif
" }}}

" I probably shouldve set this earlier...

let &cpo = s:keepcpo
unlet s:keepcpo

" Jedi:
" let g:jedi#smart_auto_mappings = 0          " if you see 'from' immediately create
" let g:jedi#popup_on_dot = 1                 " 'import'. slows things down too much
" let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
" let g:jedi#completions_enabled = 0          " we all know they based their work off you anyway

" Language Servers:
" let g:LanguageClient_serverCommands = { 'python': ['pyls'] }
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_selectionUI = 'fzf'
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Below is the global ftplugin for python for context
" =====================================================
"
" Directly below are things I wanna incorporate
"
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

" Text objects
" =====================================================
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
" =====================================================

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

" Vim filetype plugin file
" ====================================================
" Language:	python
" Maintainer:	Tom Picton <tom@tompicton.co.uk>
" Previous Maintainer: James Sully <sullyj3@gmail.com>
" Previous Maintainer: Johannes Zellner <johannes@zellner.org>
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
