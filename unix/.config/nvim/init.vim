" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'juneguun/fzf.vim'
Plug 'juneguun/seoul-256'
Plug 'scrooloose/nerdTree',
Plug 'scrooloose/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'nvie/vim-flake8'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'autozimu/LanguageClient-neovim', {'do': 'bash install.sh'} 
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'maximbaz/lightline-ale'
Plug 'ryanoasis/vim-devicons'

call plug#end()

if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Nvim Specific Options
set inccommand=split
set termguicolors

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

" Pep8 Global Options: 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" Spell Checker:
set spelllang=en
set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
" Made on termux with
" mkspell ~/.config/nvim/spell/en.hun.spl $PREFIX/share/hunspell/en_US.aff
if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
    set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
endif
set complete+=kspell 
set spellsuggest=5
map <Leader>s :setlocal spell!<CR>

" Other Global Options: 
set mouse=a                    " Automatically enable mouse usage

set cursorline
set colorcolumn=+1
set cmdheight=2
set number
set showmatch
set ignorecase
set smartcase
set smartindent
set noswapfile

if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamedplus,unnamed
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

set wildmenu                   " Show list instead of just completing
set wildmode=longest,list:longest
set complete+=.,b,u,t
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

" Mappings:
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
tnoremap <Esc> <C-W>N
map <Leader>a ggVG
map <Leader>nt <plug>NERDTreeMirrorToggle<CR>

" Plugin Configuration:
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

" Jedi:
let g:jedi#smart_auto_mappings = 0      " if you see from immediately create
let g:jedi#popup_on_dot = 0             " import. slows things down too mucb.
let g:jedi#usages_command=0             " Jedi clobbers me toggling NERDTree!
let g:jedi#use_tabs_not_buffers=1           " easy to maintain workspaces

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

let g:ale_completion_enabled = 1

" Gruvbox:
"https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
let g:gruvbox_contrast_dark = 'hard'


" Lightline
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head'
			\ },
			\ }

let g:lightline.colorscheme = 'seoul256'


"" deoplete options
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case = 1

"" disable autocomplete by default
"let b:deoplete_disable_auto_complete=1 
"let g:deoplete_disable_auto_complete=1

"" Disable the candidates in Comment/String syntaxes.
"call deoplete#custom#source('_',
            "\ 'disabled_syntaxes', ['Comment', 'String'])

"" Close the autocompleter when we leave insert mode
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" set sources
"" let g:deoplete#custom#sources.python = ['LanguageClient']
"" let g:deoplete#custom#sources.python3 = ['LanguageClient']

"" Autoselect feature
"set completeopt+=noinsert


" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)

" Language Server
" ???
"let g:LanguageClient_serverCommands = { 
            "\'sh': ['bash-language-server', 'start'], 
            "\ 'python': ['pyls', 'start']
            "\ }
