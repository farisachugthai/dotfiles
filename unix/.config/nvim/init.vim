" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

" All: {{{ 1
" Vim Plug: {{{ 2
if !filereadable('~/.vim/autoload/plug.vim')
    call system('curl -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim', { 'for': ['python', 'python3'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'nvie/vim-flake8', { 'for': ['python', 'python3'] }
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next',
    \ 'do': 'bash install.sh' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'plytophogy/vim-virtualenv'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
" Possibly wanna wrap in an if executable() or something. possibly wanna lazy
" load this too but idk how the ftdetect is gonna work
"
" Well something's not right because now ipynb files don't load at all.
Plug 'szymonmaszke/vimpyter'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" }}}

" Nvim Specific: {{{ 2
if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif
set inccommand=split                " This alone is enough to never go back
set termguicolors
" }}}

" Filetype Specific Options: {{{ 2
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

" Pep8 Global Options: {{{ 3
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_ald = 1
" }}}

" Syntax Highlighting: {{{ 3
if has('syntax')                    " if we can have syntax recognition
    syntax on                       " this has to come after the colorscheme
endif
" }}}

" Folds: {{{ 3
set foldenable
set foldlevelstart=10               " Enables most folds
set foldnestmax=5                   " Why would anything be folded this much
set foldmethod=marker
" }}}

" Buffers Windows Tabs: {{{ 3
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

set hidden
set splitbelow
set splitright
" }}}

" Spell Checker: {{{ 3
set encoding=utf-8             " Set default encoding
set spelllang=en
set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang=$HOME/.config/nvim/spell/en.utf-8.add.spl
set complete+=kspell
set spellsuggest=5
nnoremap <Leader>s :setlocal spell!<CR>

" Can be set with sudo select-default-wordlist. I opted for American insane
if filereadable('/usr/share/dict/words')
    set dictionary='/usr/share/dict/words'
    " Replace the default dictionary completion with fzf-based fuzzy completion
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
endif

if filereadable('/usr/share/dict/american-english')
    set dictionary+=/usr/share/dict/american-english
endif

if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
    set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
endif

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif
" }}}

" Fun With Clipboards: {{{ 3
if has('unnamedplus')           " Use the system clipboard.
  set clipboard+=unnamed,unnamedplus
else                            " Accomodate Termux
  set clipboard+=unnamed
endif

" Here's a new option I found out about today 08-12-18. I suppose F7 is as
" good as any other key?
set pastetoggle=<F7>
" }}}

" Other Global Options: {{{ 3
set tags+=./tags,./../tags,./*/tags     " usr_29
set background=dark
set mouse=a                             " Automatically enable mouse usage
set cursorline
set cmdheight=2
set number
set showmatch
set ignorecase
set smartcase
set smartindent
set noswapfile
if has('gui_running')
    set guifont='Fira\ Code\ Mono:11'
endif
set path+=**        			        " Make autocomplete for filenames work
set autochdir
set wildmenu                            " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set complete+=.,b,u,t                   " open buffer, open buffers, and tags
set fileignorecase
set whichwrap+=<,>,h,l,[,]              " Give reasonable line wrapping behaviour
set nojoinspaces
" }}}
" }}}

" Mappings: {{{ 2

" General Mappings: {{{ 3
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>nt :NERDTreeToggle<CR>
" Select all text quickly
nnoremap <Leader>a ggVG
" f5 to run py file
inoremap <F5> <Esc>:w<CR>:!clear;python %<CR>
" It should be easier to get help
nnoremap <leader>he :helpgrep<space>
" It should also be easier to edit the config
nnoremap <F9> :e $MYVIMRC<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprev<CR>

" what happened to that mapping i had for running a python file in visual mode
" }}}

" Terminal: {{{ 3
tnoremap <Esc> <C-W>N
" from he term. rewrite for fzf
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" }}}

" Python Language Server: {{{ 3
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}
" }}}

" Plugin Configurations: {{{ 2

" FZF: {{{ 3
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
" With :F you can now speed through file searches
let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
    \ -g "!*.{min.js,swp,o,zip}" \ -g "!{.git,node_modules,vendor}/*" '

let g:fd_command = 'fd'

command! -bang -nargs=* F call fzf#vim#grep(g:fd_command .shellescape(<q-args>), 1, <bang>0)

" could also use set grepprg here

let g:fzf_history_dir = '$HOME/.config/nvim/fzf-history'
" }}}

" NERDTree: {{{ 3
" If only NERDTree is open, close Vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1           " Sorted counts go 1, 2, 3..10,11. Default is 1, 10, 11...100...2
let g:NERDTreeChDirMode = 2             " change cwd every time NT root changes
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMouseMode = 2             " Open dirs with 1 click files with 2
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$']     "
let g:NERDTreeRespectWildIgnore = 1         " yeah i meant those ones too
" }}}

" NERDCom: {{{ 3
let g:NERDSpaceDelims = 1                   " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left'             " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1        " Trim trailing whitespace when uncommenting
" }}}

" Jedi: {{{ 3
let g:jedi#smart_auto_mappings = 0          " if you see 'from' immediately create
let g:jedi#use_tabs_not_buffers = 1         " easy to maintain workspaces
let g:jedi#show_call_signatures_delay = 50  " wait 50ms instead of 500 to show CS
let g:jedi#completions_enabled = 0          " pyls
" }}}

" Fugitive: {{{ 3
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

" Flake8 Ale Gruvbox: {{{ 3
" Flake8:
" https://github.com/nvie/vim-flake8
let g:flake8_show_in_gutter=1
" Ale:
" https://github.com/w0rp/ale
nmap <Leader>l <Plug>(ale_toggle_buffer) <CR>
let g:ale_fixers = { '*': [ 'remove_trailing_lines', 'trim_whitespace' ] }
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
" Default: `'%code: %%s'`
let g:ale_echo_msg_format = '%linter% - %code: %%s %severity%'
let g:ale_set_signs = 1 " what is the default
let g:ale_python_flake8_options = '--config ~/.config/flake8'

" Gruvbox:
"https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
" TODO: syntax is wrong but the idea is to run check before eval
" if &colorscheme=gruvbox
let g:gruvbox_contrast_dark = 'hard'
" }}}
" Python Executables: {{{ 3
if has('python3')
    " Termux settings
    if executable('/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3')
        let g:python3_host_prog = '/data/data/com.termux/files/home/virtualenvs/neovim/bin/python3'
    endif

    " Desktop
    if executable('/home/faris/miniconda3/envs/neovim_vscode/bin/python')
        let g:python3_host_prog = '/home/faris/miniconda3/envs/neovim_vscode/bin/python'
    endif

    if isdirectory("$HOME/virtualenvs")
        let g:ale_virtualenv_dir_names+="virtualenvs"
    else
        " so i found this in the help docs
        " wth is the syntax for the path? have i been doing this all wrong?
        " call mkdir($HOME . \"/tmp/foo/bar", \"p", 0700)
    endif
endif
" }}}

" Language Servers: {{{ 3
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start'],
    \ }
let g:LanguageClient_selectionUI = 'fzf'
" set completefunc=LanguageClient#complete          " already set as omnifunc
let g:LanguageClient_diagnosticsSignsMax = 10
" }}}

" Devicons: {{{ 3
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1               " adding the flags to NERDTree
" }}}

" Ultisnips: {{{ 3
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/snippets']
" }}}

" Vim_Startify: {{{ 3
let g:startify_session_sort = 1
" }}}

" Virtualenvs: {{{ 3
let g:virtualenv_directory = '~/virtualenvs'
let g:virtualenv_auto_activate = 1
" }}}

" Deoplete: {{{
let g:deoplete#enable_at_startup = 1
" }}}

" }}}
