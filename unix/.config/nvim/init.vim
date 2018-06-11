" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdTree',
Plug 'jistr/vim-nerdtree-tabs'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'nvie/vim-flake8'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


call plug#end()

filetype plugin indent on    " required from Vundle. Residually here.

if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Filetype Specific Options:
" IPython:
au BufRead,BufNewFile *.ipy setlocal filetype=python

" Web Dev:
au filetype javascript,html,css setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Markdown:
autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown

" Global Options:
" Leader:
let g:mapleader = "\<Space>"

set viminfo+=!                 " Viminfo include !
set complete-=i                " Exclude files completion

" Pep8 Global Options: 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" Spell Checker:
set encoding=utf-8             " Set default encoding

set spelllang=en
set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl

" Can be set with sudo select-default-wordlist. I opted for american insane
if filereadable('/usr/share/dict/words')
    set dictionary='/usr/share/dict/words'
endif

set complete+=kspell 
set spellsuggest=5
map <Leader>s :setlocal spell!<CR>

" Other Global Options: 
set history=10000              " Maximum history record
set autoindent                 " Indent at the same level of the previous line
set autoread                   " Automatically read a file changed outside of vim
set hlsearch                   " Highlight search terms
set incsearch                  " Find as you type search
set mouse=a                    " Automatically enable mouse usage
set ttyfast                    " Faster redrawing
set background=dark            
set cursorline                         " Cursorline so i know where I am
set colorcolumn=+1
set cmdheight=2                        " Command line is 2 char high
set ruler
set backspace=indent,eol,start " Backspace for dummies
set showcmd
set number
set showmatch
set ignorecase
set smartindent
set noswapfile

if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamedplus,unnamed
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

set wildmenu                   " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set complete+=.,b,u,t           " open buffer, open buffers, and tags
set fileignorecase
set sessionoptions-=options
set noerrorbells
set whichwrap+=<,>,h,l,[,]      " Give reasonable line wrapping behaviour

if has('persistent_undo')
    set undodir=~/.config/nvim/undodir
    set undofile	            " keep an undo file
endif
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
set tabpagemax=50
set smarttab                   " Smart tab
set laststatus=2               " Always show status line
set display=lastline           " Show as much as possible of the last line

" Mappings:
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
tnoremap <Esc> <C-W>N
map <Leader>a ggVG
map <Leader>nt <plug>NERDTreeMirrorToggle<CR>

" Plugin Configuration:
" Builtin:
"
runtime! ftplugin/man.vim
let g:ft_man_folding_enable = 0
set keywordprg=:Man

" NERDTree:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTReeQuitOnOpen = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowLineNumbers=1


" NERDTree Tabs:
let g:nerdtree_tabs_no_startup_for_diff = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_startup_cd = 1

" Jedi:
let g:jedi#smart_auto_mappings = 0      " if you see from immediately create
let g:jedi#popup_on_dot = 0             " import. slows things down too mucb.
let g:jedi#usages_command=0             "Jedi clobbers me toggling NERDTree!
let g:jedi#use_tabs_not_buffers=1           " easy to maintain workspaces
nnoremap <leader>n :call jedi#usages()<cr>

" Tagbar:
" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=1

" Ale:
" https://github.com/w0rp/ale
" <Leader>a is already mapped so use l for lint
nmap <Leader>l <Plug>(ale_toggle_buffer)


" Gruvbox:
"https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
let g:gruvbox_contrast_dark = 'hard'

" Language Servers
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start']
    \ }
