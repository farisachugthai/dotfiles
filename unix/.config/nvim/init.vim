" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai


if !filereadable('~/.local/share/nvim/site/autoload/plug.vim')
    call system('curl  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ --proto=https https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    " normal PlugInstall +UpdateRemotePlugins :clo
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
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
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'

call plug#end()

if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif

" Nvim Specific Options
set inccommand=split                " This alone is enough to never go back
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
set encoding=utf-8             " Set default encoding
set spelllang=en
set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
" Can be set with sudo select-default-wordlist. I opted for american insane
if filereadable('/usr/share/dict/words')
    set dictionary='/usr/share/dict/words'
    " Replace the default dictionary completion with fzf-based fuzzy completion 
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')

endif
" Made on termux with
" mkspell ~/.config/nvim/spell/en.hun.spl $PREFIX/share/hunspell/en_US.aff
if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
    set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
endif
set complete+=kspell 
set spellsuggest=5
map <Leader>s :setlocal spell!<CR>

" Other Global Options: 
set background=dark
set mouse=a                    " Automatically enable mouse usage
set cursorline
" don't know what i'm doing wrong here but only recently started learning viml
"if g:textwidth == 0             " Basically saying is it ever unset? Set it 100
    "setlocal colorcolumn = 100
"elseif                          " how do we check that a variable is set to a non-zero integer?
    "setlocal colorcolumn+=1
"else                            " Don't actually think this part does anything?
    "setlocal colorcolumn=+1
"endif
set cmdheight=2
set number
set showmatch
set ignorecase
set smartcase
set smartindent
set noswapfile
set guifont='Fira\ Code\ Mono:h11'

if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamedplus,unnamed
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

set wildmenu                   " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
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
tnoremap <Esc> <C-W>N
map <Leader>a ggVG
map <Leader>nt <plug>NERDTreeMirrorToggle<CR>

" Plugin Configuration:
"
" fzf
" Adapted from:
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
let g:NERDTreeMouseMode=2           " Give more functionality to the mouse
                                    " while navigating NERDTree

" NERDTree Tabs:
let g:nerdtree_tabs_no_startup_for_diff = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_startup_cd = 1

" Jedi:
let g:jedi#smart_auto_mappings = 0      " if you see from immediately create
let g:jedi#popup_on_dot = 0             " import. slows things down too mucb.
let g:jedi#use_tabs_not_buffers=1           " easy to maintain workspaces
nnoremap <leader>n :call jedi#usages()<cr>
" HOW IN THE WORLD IS JEDI GLOBERRING 0 THAT IS SO INCONVENIENT


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

" Tagbar:
" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_in_gutter=1

" Ale:
" https://github.com/w0rp/ale
" <Leader>a is already mapped so use l for lint
nmap <Leader>l <Plug>(ale_toggle_buffer)

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


" Language Servers
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start']
    \ }


"" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Under the assmption we're in the right virtualenv
" Might need to do a try catch and cathc with a list of providers
let g:python3_host_prog = '$HOME/miniconda/envs/neovim_vscode/bin/python'

"" disable autocomplete by default
let b:deoplete_disable_auto_complete=1 
let g:deoplete_disable_auto_complete=1

"" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

"" Close the autocompleter when we leave insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" set sources aka really still trying to figure out how tf language clientworks
"" let g:deoplete#custom#sources.python = ['LanguageClient']
"" let g:deoplete#custom#sources.python3 = ['LanguageClient']

"" Autoselect feature
set completeopt+=noinsert

" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
"Note: You must enable
"|deoplete-source-attribute-is_debug_enabled| to debug the
"sources.
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)

" Deoplete going crazy with the dictionary completions
" Sample configuration for dictionary source with multiple
" dictionary files.
setlocal dictionary+=/usr/share/dict/words
setlocal dictionary+=/usr/share/dict/american-english
" Remove this if you'd like to use fuzzy search
"call deoplete#custom#source(
"\ 'dictionary', 'matchers', ['matcher_head'])
"" If dictionary is already sorted, no need to sort it again.
"call deoplete#custom#source(
"\ 'dictionary', 'sorters', [])
"" Do not complete too short words
"call deoplete#custom#source(
"\ 'dictionary', 'min_pattern_length', 4)
"
" Quite honestly I don't know what most of these commands do but I'm damn sure
" I'm gonna figure it out
" Still getting a weird error about my remote plugins and checkhealth is
" saying that something is set wrong and that i need to enable debugging. Pft
