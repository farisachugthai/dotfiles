" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

" All: {{{ 1

" Vim Plug: {{{ 2

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim', { 'for': ['python', 'python3'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next',
    \ 'do': 'bash install.sh' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" }}}

" Nvim Specific: {{{ 2
set background=dark

if filereadable(glob('~/.config/nvim/init.vim.local'))
    source ~/.config/nvim/init.vim.local
endif
set inccommand=split                " This alone is enough to never go back
set termguicolors
" }}}

" Global Options: {{{ 2
" Leader:
let g:mapleader = "\<Space>"

" Pep8 Global Options: {{{ 3
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
let g:python_highlight_all = 1
" }}}

" Folds: {{{ 3
set foldenable
set foldlevelstart=1                " Enables most folds
set foldnestmax=10                  " Why would anything be folded this much
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
setlocal spelllang=en,en_us         " should use setlocal since we toggle spell checking on and off
setlocal spellfile=~/.config/nvim/spell/en.utf-8.add

" if filereadable($VIMRUNTIME/spell/en.utf-8.spl)
"     set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
" endif
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
set complete+=kspell
set spellsuggest=5

" Can be set with sudo select-default-wordlist. I opted for American insane
" how did the line below get deleted....
if filereadable('/usr/share/dict/words')
    set dictionary='/usr/share/dict/words'
    " Replace the default dictionary completion with fzf-based fuzzy completion
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
endif

" how did the line below get deleted....
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

" Autocompletion: {{{ 3
set wildmenu                            " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set fileignorecase                      " when searching for files don't use case
" I just realized I only have completefunc/omnifunc set in ftplugins.
" You should have SOMETHING set globally for completefunc. Omni is ftspecific
" so not that one.
" }}}

" Other Global Options: {{{ 3
set tags+=./tags,./../tags,./*/tags     " usr_29
set mouse=a                             " Automatically enable mouse usage
set cursorline
set cmdheight=2
set number
set showmatch
set ignorecase
set smartcase
set smartindent
set autoindent                          " :he options: set with smartindent
set noswapfile
if has('gui_running')
    set guifont='Fira\ Code\ Mono:11'
endif
set path+=**        			        " Make autocomplete for filenames work
set autochdir
set whichwrap+=<,>,h,l,[,]              " Give reasonable line wrapping behaviour
set nojoinspaces
" }}}

" }}}

" Mappings: {{{ 2

" General Mappings: {{{ 3
" Note that F7 is bound to pastetoggle so don't map it
" Navigate windows more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Navigate tabs more easily
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprev<CR>
" NERDTree has sluggish startuptimes
nnoremap <Leader>nt :NERDTreeToggle<CR>
" Select all text quickly
nnoremap <Leader>a ggVG
" f5 to run *.py. currently doesn't work or at least doesn't display anything
inoremap <F5> <Esc>:w<CR>:!clear;python %
" It should be easier to get help
nnoremap <leader>he :helpgrep<space>
" It should also be easier to edit the config
nnoremap <F9> :e $MYVIMRC<CR>

" what happened to that mapping i had for running a python file in visual mode
" i tried doing this mapping with all modes but there's no reason
" for it to be activated in normal mode and it's annoying in visual
inoremap jk <Esc>

" }}}

" Spell Checking: {{{ 3
" it has to wait to see if i'm gonna do s= instead of just s
" and the delay is awful. sorry for changing one of my oldest mappings!
nnoremap <Leader>sp :setlocal spell!<CR>
" Based off the default value for spell suggest
nnoremap <Leader>s= :norm z=<CR>
" }}}

" Emacs in the Ex line: {{{ 3

" For Emacs-style editing on the command-line:
" start of line
:cnoremap <C-A>		<Home>
" back one character
:cnoremap <C-B>		<Left>
" delete character under cursor
:cnoremap <C-D>		<Del>
" end of line
:cnoremap <C-E>		<End>
" forward one character
:cnoremap <C-F>		<Right>
" recall newer command-line
:cnoremap <C-N>		<Down>
" recall previous (older) command-line
:cnoremap <C-P>		<Up>
" back one word
:cnoremap <Esc><C-B>	<S-Left>
" forward one word
:cnoremap <Esc><C-F>	<S-Right>

" }}}

" Terminal: {{{ 3
" If running a terminal in Vim, go into Normal mode with Esc
tnoremap <Esc> <C-W>N
" from he term. rewrite for fzf
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" From he terminal
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }}}

" Python Language Server: {{{ 3
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

" ALE: {{{ 3
nnoremap <Leader>l <Plug>(ale_toggle_buffer) <CR>
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

" }}}

" Plugin Configurations: {{{ 2

" FZF: {{{ 3
" In case you were not aware your FZF and Ag commands don't work
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

" TODO: get changes from termux: Need to get ag commands.
" With :F you can now speed through file searches
let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
    \ -g "!*.{min.js,swp,o,zip}" \ -g "!{.git,node_modules,vendor}/*" '

let g:fd_command = 'fd'

command! -bang -nargs=* F call fzf#vim#grep(g:fd_command .shellescape(<q-args>), 1, <bang>0)

" could also use set grepprg here

let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" NERDTree: {{{ 3
" If only NERDTree is open, close Vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1               " Sorted counts go 1, 2, 3..10,11. Default is 1, 10, 11...100...2
let g:NERDTreeChDirMode = 2                 " change cwd every time NT root changes
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMouseMode = 2                 " Open dirs with 1 click files with 2
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$', '\.git$']
let g:NERDTreeRespectWildIgnore = 1         " yeah i meant those ones too
" }}}

" NERDCom: {{{ 3
let g:NERDSpaceDelims = 1                   " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left'             " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1        " Trim trailing whitespace when uncommenting
" }}}

" ALE: {{{ 3
let g:ale_fixers = { '*': [ 'remove_trailing_lines', 'trim_whitespace' ] }
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
" Default: `'%code: %%s'`
let g:ale_echo_msg_format = '%linter% - %code: %%s %severity%'
let g:ale_set_signs = 1 " what is the default
" }}}

" Devicons: {{{ 3
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1               " adding the flags to NERDTree
" }}}

" Ultisnips: {{{ 3
let g:UltiSnipsUsePythonVersion = 3
" still haven't decided on nvim or vim dir
let g:UltiSnipsSnippetDir=[$HOME.'/.config/nvim/UltiSnips']
" the line below is probably gonna slow things down a lot
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
" I like these mappings
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnips_python_quoting_style='GOOGLE'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

let g:snips_author='Faris Chugthai'
let g:snips_email='farischugthai@gmail.com'
let g:snips_github='https://github.com/farisachugthai'
" }}}

" Vim_Startify: {{{ 3
let g:startify_session_sort = 1
" }}}

" Deoplete: {{{ 3
let g:deoplete#enable_at_startup = 1
" }}}

" Gruvbox: {{{ 3
" Load the colorscheme last. Noticeable startuptime improvement
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
" }}}

" }}}

" Filetype Specific Options: {{{ 2
" IPython:
au BufRead,BufNewFile *.ipy setlocal filetype=python
" Web Dev:
au filetype javascript,html,css setlocal shiftwidth=2 softtabstop=2 tabstop=2
" Markdown:
autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
" }}}

" }}}
