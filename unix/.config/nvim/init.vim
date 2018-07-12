" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

" Full fold: {{{
" Vim-plug {{{
if !filereadable('~/.local/share/nvim/site/autoload/plug.vim')
    call system('curl  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ --proto=https https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    " normal PlugInstall +UpdateRemotePlugins :clo
    " Above didn't work. Unsure why.
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'davidhalter/jedi-vim', { 'for': ['python', 'python3'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'nvie/vim-flake8', { 'for': ['python', 'python3'] }
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'autozimu/LanguageClient-neovim', {'do': 'bash install.sh'} 
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'maximbaz/lightline-ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-markdown', { 'for': ['md', 'markdown'] }         " Better markdown support 
" Multiple Plug commands can be written in a single line using | separators 
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' , { 'on': [] }
Plug 'plytophogy/vim-virtualenv', { 'for': ['python', 'python3'] }

call plug#end()
" }}}
" load deop and ultisnips after entering insert mode. note plugin confs for
" loading deop after first enter. redundant?
" augroup load_us_deop
"     autocmd!
"     autocmd InsertEnter * call plug#load('ultisnips', 'deoplete'
"                 \| autocmd! load_us_deop)
" augroup END

if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Nvim Specific Options
set inccommand=split                " This alone is enough to never go back
set termguicolors

" Filetype Specific Options: {{{
" Python:
" Should wrap in a func. Dont want to have happen every time.
" au BufNewFile *.py 0r ~/.config/nvim/skeleton.py

" IPython:
au BufRead,BufNewFile *.ipy setlocal filetype=python

" Web Dev:
au filetype javascript,html,css setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Markdown:
autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
" }}}
" Global Options: {{{
" Leader:
let g:mapleader = "\<Space>"

" Pep8 Global Options: 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" Spell Checker: {{{
set encoding=utf-8             " Set default encoding
set spelllang=en
set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
" Can be set with sudo select-default-wordlist. I opted for american insane
if filereadable('/usr/share/dict/words')
    setlocal dictionary='/usr/share/dict/words'
    " Replace the default dictionary completion with fzf-based fuzzy completion 
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
endif

if filereadable('/usr/share/dict/american-english')
    setlocal dictionary+=/usr/share/dict/american-english
endif

" Made on termux with
" TODO: Check if termux and if not readable run the command below
" mkspell ~/.config/nvim/spell/en.hun.spl $PREFIX/share/hunspell/en_US.aff
if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
    set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
endif
set complete+=kspell 
set spellsuggest=5
map <Leader>s :setlocal spell!<CR>
" }}}

" Folds
set foldenable
set foldlevelstart=10               " Enables most folds
set foldnestmax=5                   " Why would anything be folded this much
set foldmethod=indent               " Gotta love Python

" Other Global Options: 
set tags+=./tags,./../tags,./*/tags      " usr_29
set background=dark
set mouse=a                    " Automatically enable mouse usage
set cursorline
set cmdheight=2
set number
set showmatch
set ignorecase
set smartcase
set smartindent
set noswapfile
set guifont='Fira\ Code\ Mono:h11'
set path+=**        			" Make autocomplete for filenames work
set autochdir

if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamed,unnamedplus
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

set wildmenu                   " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set complete+=.,b,u,t           " open buffer, open buffers, and tags
set fileignorecase
set whichwrap+=<,>,h,l,[,]      " Give reasonable line wrapping behaviour

set nojoinspaces

" Syntax Highlighting:
if has('syntax')                " if we can have syntax recognition
    syntax on                   " this has to come after the colorscheme
endif
set modeline                    " easy to set filetype with modeline

" Buffers Windows Tabs:
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry
set hidden
set splitbelow
set splitright
" }}}
" Mappings: {{{
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Select all text quickly
nmap <Leader>a ggVG
" turn on NERDTree [and remember to not inline comments on map cmds!!!
nmap <Leader>nt <plug>NERDTree<CR>           
"o for on/off
nmap <Leader>no <plug>NERDTreeToggle<CR>     
" f5 to run py file
imap <F5> <Esc>:w<CR>:!clear;python %<CR>       

" Terminal
tnoremap <Esc> <C-W>N
" tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" from he term. rewrite for fzf

" From he map
"
" com -nargs=1 -bang -complete=customlist,EditFileComplete  EditFile edit<bang> <args>
" fun EditFileComplete(A,L,P)
"     return split(globpath(&path, a:A), '\n')
" endfun
" }}}

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
" Plugin Configuration: {{{
" fzf: {{{
" Adapted from:
" https://github.com/tony/vim-config-framework/blob/2018-06-09/plugins.settings/contrib/fzf.vim

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))   " noqa
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}
" NERDTree: {{{
" If only NERDTree is open, close Vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeQuitOnOpen = 1           " close NT after opening a file with o, i or t 
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1           " Sorted counts go 1, 2, 3..10,11. default is 1, 10, 11...100...2
let g:NERDTreeChDirMode = 2         " change cwd every time NT root changes
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMouseMode = 2           " Give more functionality to the mouse while navigating NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree. Has a default so append to it
let g:NERDTreeRespectWildIgnore = 1         "yeah i meant those ones too

" NERDTree Tabs:
let g:nerdtree_tabs_no_startup_for_diff = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_startup_cd = 1

" NERDCom:
let g:NERDSpaceDelims = 1       " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing whitespace when uncommenting
" }}}

" Jedi:
let g:jedi#smart_auto_mappings = 0          " if you see 'from' immediately create
let g:jedi#popup_on_dot = 1                 " 'import'. slows things down too much
let g:jedi#use_tabs_not_buffers = 1           " easy to maintain workspaces

" Fugitive: {{{
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gE :Gedit<space>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gR :Gread<space>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gW :Gwrite!<CR>
nnoremap <silent> <leader>gq :Gwq<CR>
nnoremap <silent> <leader>gQ :Gwq!<CR>
" }}}
" Tagbar:
" https://github.com/majutsushi/tagbar
" Termux uses Universal Ctags and apparently tagbar doesn't like that.
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 0  " do not automatically jump to tagbar when opened
let g:tagbar_autoclose = 1  " when you jump to a tag close tagbar
" autocmd FileType python nested :TagbarOpen  " open tagbar when you see .py
" autocmd BufWinLeave python nested :TagbarClose
let g:tagbar_show_linenumbers = 1

" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_in_gutter=1

" Ale:
" https://github.com/w0rp/ale
" <Leader>a is already mapped so use l for lint
nmap <Leader>l <Plug>(ale_toggle_buffer)

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline+=%#ALEWarningSign#                      " Warning color
set statusline+=%{LinterStatus()}    

" Gruvbox:
"https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
" TODO: Check if gruvbox is the colorscheme
let g:gruvbox_contrast_dark = 'hard'

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


function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline.colorscheme = 'seoul256'
" }}}

" pyls
if has('python3')
    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    if executable('/home/faris/miniconda3/envs/neovim_vscode/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim_vscode/bin/python'
    endif
endif

" Language Servers:
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start']
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = 'fzf'
let g:loaded_python_provider = 1        " disable py2 support

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
" Devicons
let g:webdevicons_enable = 1

" adding the flags to NERDTree 
let g:webdevicons_enable_nerdtree = 1
" }}}
" }}}
" Vim: set foldmethod=marker :
