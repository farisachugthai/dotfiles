" init.vim
" Neovim configuration
" Maintainer: Faris Chugthai

setlocal foldlevel=1
" All: {{{ 1

" About: {{{ 2
let g:snips_author = 'Faris Chugthai'
let g:snips_email = 'farischugthai@gmail.com'
let g:snips_github = 'https://github.com/farisachugthai'
" }}}

" Vim Plug: {{{ 2
" let's have these share a directory since i don't use different plugins
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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'

call plug#end()
" }}}

" Nvim Specific: {{{ 2
set background=dark                     " set as early as possible

if filereadable(glob('~/.config/nvim/autocorrect.vim'))
    source ~/.config/nvim/autocorrect.vim
endif
set inccommand=split                    " This alone is enough to never go back
set termguicolors

" unabashedly stolen from junegunn dude is too good.
let s:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h').'/init.vim.local'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif

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
set foldlevelstart=1                    " Enables most folds
set foldnestmax=10                      " Why would anything be folded this much
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
set encoding=UTF-8                      " Set default encoding
set fileencoding=UTF-8
set spelllang=en
" set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.spl
set spelllang+=$HOME/.config/nvim/spell/en.utf-8.add.spl
set complete+=kspell
set spellsuggest=5
" Can be set with sudo select-default-wordlist. I opted for American insane
if filereadable('/usr/share/dict/words')
    setlocal dictionary+='/usr/share/dict/words'
" Replace the default dictionary completion with fzf-based fuzzy completion
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
endif
if filereadable('/usr/share/dict/american-english')
    setlocal dictionary+=/usr/share/dict/american-english
endif
if filereadable('$HOME/.config/nvim/spell/en.hun.spl')
    set spelllang+=$HOME/.config/nvim/spell/en.hun.spl
endif
" }}}

" Fun With Clipboards: {{{ 3
if has('unnamedplus')                   " Use the system clipboard.
  set clipboard+=unnamed,unnamedplus
else                                    " Accomodate Termux
  set clipboard+=unnamed
endif

set pastetoggle=<F7>
" }}}

" Other Global Options: {{{ 3
set tags+=./tags,./../tags,./*/tags     " usr_29
set mouse=a                             " Automatically enable mouse usage
set cursorline
set colorcolumn=+1
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
set path+=**        			        " Recursively search dirs with :find
set autochdir
set wildmenu                            " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set complete+=.,b,u,t                   " open buffer, open buffers, and tags
set fileignorecase
set whichwrap+=<,>,h,l,[,]              " Reasonable line wrapping
set nojoinspaces
set diffopt=vertical,context:3          " vertical split diffs. def cont is 6

if has('persistent_undo')
    set undodir=~/.vim/undodir
    set undofile	" keep an undo file (undo changes after closing)
endif
set modeline
" }}}

" }}}

" Mappings: {{{ 2

" General Mappings: {{{ 3
" Navigate windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Navigate tabs easier
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprev<CR>
" Simple way to speed up startup hugely
nnoremap <Leader>nt :NERDTreeToggle<CR>
" Select all text quickly
nnoremap <Leader>a ggVG
" f5 to run py file
inoremap <F5> <Esc>:w<CR>:!clear;python %<CR>
" It should be easier to get help
nnoremap <leader>he :helpgrep<space>
" It should also be easier to edit the config
nnoremap <F9> :e $MYVIMRC<CR>
" Toggle the spell checker
nnoremap <Leader>s :setlocal spell!<CR>
" }}}

" Terminal: {{{ 3
tnoremap <Esc> <C-W>N
" from he term. rewrite for fzf
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" }}}

" Ale: {{{ 3
" So these mappings would clobber so many things but its a good thought to
" keep in the back of your mind
" nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
" nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
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

" Also thinking about throwing a few for ex around. something like
" cnoremap C-a Beginning of line
" }}}

" Plugin Configuration: {{{ 2

" FZF: {{{ 3
" Most important thing to define is the sink option.
" use e to open the selected file in a tab
" on nvim fzf starts in a terminal.

" produces an error that fzf#run isn't a recognized fxn???
" call fzf#run({'sink': 'tabedit', 'options': [ '--multi', '--reverse' ]})

" When fzf starts in a terminal buffer, you may want to hide the statusline of
" the containing buffer.

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" You can optionally set:
" g:fzf_layout
" `call fzf#run({'left': '30%'})` or `let g:fzf_layout = {'left': '30%'}`

" Default fzf layout
    " - down / up / left / right
    " let g:fzf_layout = { 'down': '~40%' }

    " " You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
    " let g:fzf_layout = { 'window': 'enew' }
    " let g:fzf_layout = { 'window': '-tabnew' }
    " let g:fzf_layout = { 'window': '10split enew' }
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

" `fzf#wrap([name string,] [opts dict,] [fullscreen boolean])` is a helper
" function that decorates the options dictionary so that it understands
" `g:fzf_layout`, `g:fzf_action`, `g:fzf_colors`, and `g:fzf_history_dir` like
" `:FZF`.

" With :F you can now speed through file searches

let g:ag_command = 'ag --smart-case -u -g " " --'
" TODO: need to look through this command because i keep getting an out of
" index error
command! -bang -nargs=* F call fzf#vim#grep(g:ag_command .shellescape(<q-args>), 1, <bang>0)
" could also use set grepprg here
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" NERDTree: {{{ 3
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeChDirMode = 2                         " change cwd every time NT root changes
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMouseMode = 2                         " Open dirs with 1 click files with 2
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeRespectWildIgnore = 1                 " yeah i meant those ones too
" }}}

" NERDCom: {{{ 3
let g:NERDSpaceDelims = 1                           " can we give the code some room to breathe?
let g:NERDDefaultAlign = 'left'                     " Align line-wise comment delimiters flush left
let g:NERDTrimTrailingWhitespace = 1                " Trim trailing whitespace when uncommenting
" }}}

" Ale: {{{ 3
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
" Default: `'%code: %%s'`
let g:ale_echo_msg_format = '%linter% - %code: %%s %severity%'
let g:ale_set_signs = 1                             " what is the default
let g:ale_fixers = { '*': [ 'remove_trailing_lines', 'trim_whitespace' ]}
" }}}

" Devicons: {{{ 3
let g:airline_powerline_fonts = 1
" }}}

" Vim_Startify: {{{ 3
let g:startify_session_sort = 1
" }}}

" Ultisnips: {{{ 3
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDir = [ '~/.config/nvim/Ultisnips' ]
let g:UltiSnips_python_quoting_style = 'GOOGLE'
let g:UltiSnipsEnableSnipMate = 0                   " isn't working at all
" }}}

" Gruvbox: {{{ 3
" TODO: syntax is wrong but the idea is to run check before eval
" if &colorscheme=gruvbox
let g:gruvbox_contrast_dark = 'hard'
" Speed up init by saving syntax /colo for last
colorscheme gruvbox
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

" Functions: {{{ 2
" Credit to Junegunn

function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e todo -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e todo -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()


" Heres one where he uses fzf and Explore to search a packages docs

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction
" }}}

" }}}
