" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

" {{{ 1
" Vim-plug {{{ 2
if !filereadable('~/.local/share/nvim/site/autoload/plug.vim')
    call system('curl  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ --proto=https https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim', { 'for': ['python', 'python3'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'nvie/vim-flake8', { 'for': ['python', 'python3'] }
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'autozimu/LanguageClient-neovim', {'do': 'bash install.sh', 'for': ['python', 'python3', 'bash', 'rust' ] }
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-markdown', { 'for': ['md', 'markdown'] }         " Better markdown support 
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'plytophogy/vim-virtualenv', { 'for': ['python', 'python3'] }
Plug 'vim-airline/vim-airline'

call plug#end()
" }}}
" Nvim specific: {{{ 2
if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Nvim Specific Options:
set inccommand=split                " This alone is enough to never go back
set termguicolors
" }}}
" Filetype Specific Options: {{{ 2
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
" Global Options: {{{ 2
" Leader:
let g:mapleader = "\<Space>"

" Pep8 Global Options: 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" Spell Checker: {{{ 3
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

" Folds:
set foldenable
set foldlevelstart=10               " Enables most folds
set foldnestmax=5                   " Why would anything be folded this much
set foldmethod=indent               " Gotta love Python

" Other Global Options: {{{ 3
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
set modeline                    " easy to set filetype with modeline

set wildmenu                   " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set complete+=.,b,u,t           " open buffer, open buffers, and tags
set fileignorecase
set whichwrap+=<,>,h,l,[,]      " Give reasonable line wrapping behaviour

set nojoinspaces
" }}}
" Syntax Highlighting:
if has('syntax')                " if we can have syntax recognition
    syntax on                   " this has to come after the colorscheme
endif

" Buffers Windows Tabs:
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry
set hidden
set splitbelow
set splitright

" Fun With Clipboards: {{{ 3
if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamed,unnamedplus
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

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
" }}}
" Mappings: {{{ 3
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Select all text quickly
nmap <Leader>a ggVG
" f5 to run py file
imap <F5> <Esc>:w<CR>:!clear;python %<CR>

" Terminal:
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

" Plugin Configuration: {{{ 3
" fzf: {{{ 4
" Adapted from:
" https://github.com/tony/vim-config-framework/blob/2018-06-09/plugins.settings/contrib/fzf.vim

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
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

" Here's a ripgrep integration for ya

let g:fzf_history_dir = '$HOME/.config/nvim/fzf-history'
" }}}
" NERDTree: {{{ 4
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

" NERDCom:
let g:NERDSpaceDelims = 1       " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing whitespace when uncommenting
" }}}
" Jedi: {{{ 4
let g:jedi#smart_auto_mappings = 0          " if you see 'from' immediately create
let g:jedi#popup_on_dot = 1                 " 'import'. slows things down too much
let g:jedi#use_tabs_not_buffers = 1           " easy to maintain workspaces
" }}}
" Fugitive: {{{ 4
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

" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_in_gutter=1

" Ale:
" https://github.com/w0rp/ale
" <Leader>a is already mapped so use l for lint
nmap <Leader>l <Plug>(ale_toggle_buffer)

" Gruvbox:
let g:gruvbox_contrast_dark = 'hard'

" Pyls: {{{ 4
if has('python3')
    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    if executable('/home/faris/miniconda3/envs/neovim_vscode/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim_vscode/bin/python'
    endif
endif
" }}}
" Language Servers: {{{ 4
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start']
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = 'fzf'
" let g:loaded_python_provider = 1        " disable py2 support
" location of bls on termux
" /data/data/com.termux/files/home/.local/share/yarn/global/node_modules/bash-language-server/bin/main.js
" }}}
" Devicons:
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1       " adding the flags to NERDTree
" }}}
" Vim: set foldmethod=marker :
