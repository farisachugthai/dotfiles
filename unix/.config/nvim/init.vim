" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

" Full fold: {{{
" Vim-plug {{{
if !filereadable('~/.local/share/nvim/site/autoload/plug.vim')
    call system('curl -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next',
    \ 'do': 'bash install.sh' }
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'rust-lang/rust.vim'

call plug#end()
" }}}
if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Nvim Specific Options:
set inccommand=split                " This alone is enough to never go back
set termguicolors

" Filetype Specific Options: {{{2
" IPython:
au BufRead,BufNewFile *.ipy setlocal filetype=python

" Web Dev:
au filetype javascript,html,css setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Markdown:
autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
" }}}
" Global Options: {{{2
" Leader:
let g:mapleader = "\<Space>"

" Pep8 Global Options:
set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1

" temp
set nospell
" Spell Checker: {{{3
" set encoding=utf-8             " Set default encoding
" set spelllang=en
" " set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
" set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
" set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
" set complete+=kspell
" set spellsuggest=5
" map <Leader>s :setlocal spell!<CR>
" " Can be set with sudo select-default-wordlist. I opted for american insane
" if filereadable('/usr/share/dict/words')
"     set dictionary='/usr/share/dict/words'
"     " Replace the default dictionary completion with fzf-based fuzzy completion
"     inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
" endif
" if filereadable('/usr/share/dict/american-english')
"     set dictionary+=/usr/share/dict/american-english
" endif
" " Made on termux with
" " TODO: Check if termux and if not readable run the command below
" " mkspell ~/.config/nvim/spell/en.hun.spl $PREFIX/share/hunspell/en_US.aff
" " TODO2: Also are you supposed to end the spellfile with .add?
" if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
"     set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
" endif
" }}}

" Folds:
set foldenable
set foldlevelstart=10               " Enables most folds
set foldnestmax=5                   " Why would anything be folded this much
set foldmethod=marker

" Other Global Options:{{{
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

" Mappings:
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Select all text quickly
nmap <Leader>a ggVG

runtime! ftplugin/man.vim           " Access man pages inside nvim
let g:ft_man_folding_enable = 0     " Pretty sure this is default enabled
set keywordprg=:Man

" Run a py file only in insert mode. In normal mode activate pyls
"
imap <F5> <Esc>:w<CR>:!clear;python %<CR>
" Dude read this genius way to run python files
"https://stackoverflow.com/a/501698
:vnoremap <f5> :!python<CR>
" now simply highlight the 'cells' you wanna run!


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
" Plugin Configuration: {{{
" fzf: {{{
" https://github.com/tony/vim-config-framework/blob/2018-06-09/plugins.settings/contrib/fzf.vim

let g:fzf_action = {
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
let g:NERDTreeQuitOnOpen = 1            " If only NERDTree is open, close Vim
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeChDirMode = 2         " change cwd every time NT root changes
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMouseMode = 2         " open dir on mouse click
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeRespectWildIgnore = 1
" NERDCom:
let g:NERDSpaceDelims = 1       " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing whitespace when uncommenting
" }}}
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
" Ale:
" https://github.com/w0rp/ale
" <Leader>a is already mapped so use l for lint
nmap <Leader>l <Plug>(ale_toggle_buffer)<CR>
let g:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fix_on_save = 1

" Gruvbox:
"https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
let g:gruvbox_contrast_dark = 'hard'
" Putting deoplete in after now
" Devicons:
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
" }}}
" }}}
" Vim: set foldmethod=marker :
