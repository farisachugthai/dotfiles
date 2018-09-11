" init.vim
" Neovim configuration


" All: {{{ 1

" About: {{{ 2
let g:snips_author = 'Faris Chugthai'
let g:snips_email = 'farischugthai@gmail.com'
let g:snips_github = 'https://github.com/farisachugthai'
" }}}

" Nvim_OS: {{{ 2
" Gonna start seriously consolidating vimrc and init.vim this is so hard
" to maintain
" Let's setup all the global vars we need
" Wait am i assigning these vars correctly? man fuck vimscript

if has('nvim')
    let s:root = '~/.config/nvim'
    let s:conf = '~/.config/nvim/init.vim'
else
    let s:root = '~/.vim'
    let s:conf = '~/.vim/vimrc'
endif

if exists('$PREFIX')
    let s:usr_d = '$PREFIX'     " might need to expand on use
    let s:OS= 'Android'
else
    let s:usr_d = '/usr'
    let s:OS = 'Linux'
endif
" }}}

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
" Yeah so we gotta do this BS again. Seriously try to keep odifications at 0
" until the dust settles. I just wanted to note that it'd be a good enough idea to put on all 4
" rc files to add the clipboard providor tmux thing. nvim specific.
" made me think and realize that python3_host_prog is probably also something that should go in nvim specific
" i mean that is if you wanna take it out of the ftplugin
" holy shit we're moving so slow. yeah man i'm sure it's languageclient this only ever happens with that.
set background=dark

let s:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h').'/init.vim.local'
if filereadable(s:local_vimrc)
    execute 'source' s:local_vimrc
endif

set inccommand=split                " This alone is enough to never go back
set termguicolors
" }}}

" Global Options: {{{ 2

" Leader_Viminfo: {{{ 3
let g:mapleader = "\<Space>"

if !has('nvim')
    set viminfo='100,<200,s200,n$HOME/.vim/viminfo
endif
" }}}

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
set encoding=UTF-8              " Set default encoding
scriptencoding UTF-8            " Vint believes encoding should be done first
set fileencoding=UTF-8
set spelllang=en,en_us

" if !has('nvim')
"     set spelllang+=$VIMRUNTIME/spell/en.utf-8.spl
" endif

set complete+=kspell                    " Autocomplete in insert mode
set spellsuggest=5                      " Limit the number of suggestions from 'spell suggest'

" Can be set with sudo select-default-wordlist. I opted for American insane
if filereadable('/usr/share/dict/words')
    set dictionary+=/usr/share/dict/words
    " Replace the default dictionary completion with fzf-based fuzzy completion
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
endif

if filereadable('/usr/share/dict/american-english')
    set dictionary+=/usr/share/dict/american-english
endif

" if filereadable(glob('~/.config/nvim/spell/en.hun.spl'))
"     set spelllang+=~/.config/nvim/spell/en.hun.spl
" endif

if filereadable(glob('~/.vim/autocorrect.vim'))
    source ~/.vim/autocorrect.vim
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

" Autocompletion: {{{ 3
set wildmenu                            " Show list instead of just completing
set wildmode=longest,list:longest       " Longest string or list alternatives
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set fileignorecase                      " when searching for files don't use case

" set completefunc here and then let b:omnifunc in ftplugins
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
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
set autoindent smartindent              " :he options: set with smartindent
set noswapfile
set fileformat=unix

if has('gui_running')
    set guifont='Fira\ Code\ Mono:11'
endif

set path+=**        			        " Make autocomplete for filenames work
set autochdir
set fileformat=unix
set whichwrap+=<,>,h,l,[,]              " Give reasonable line wrapping behaviour
set modeline
set undofile
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
nnoremap <A-Right> :tabnext<CR>
nnoremap <A-Left> :tabprev<CR>

" T Pope
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Simple way to speed up startup
nnoremap <Leader>nt :NERDTreeToggle<CR>
" Select all text quickly
nnoremap <Leader>a ggVG
" f5 to run *.py. currently doesn't work or at least doesn't display anything
inoremap <F5> <Esc>:w<CR>:!clear;python %
" It should be easier to get help
nnoremap <leader>he :helpgrep<space>
" It should also be easier to edit the config
nnoremap <F9> :e $MYVIMRC<CR>

inoremap jk <Esc>
vnoremap jk <Esc>

" Junegunn
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
xnoremap < <gv
xnoremap > >gv
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
cnoremap <C-A> <Home>
" back one character
cnoremap <C-B> <Left>
" delete character under cursor
cnoremap <C-D> <Del>
" end of line
cnoremap <C-E> <End>
" forward one character
cnoremap <C-F> <Right>
" recall newer command-line
cnoremap <C-N> <Down>
" recall previous (older) command-line
cnoremap <C-P> <Up>
" back one word
cnoremap <Esc><C-B>	<S-Left>
" forward one word
cnoremap <Esc><C-F> <S-Right>
" }}}

" Terminal: {{{ 3
" If running a terminal in Vim, go into Normal mode with Esc
tnoremap <Esc> <C-W>N
" from he term. rewrite for fzf
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
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

" ALE: {{{ 3
nnoremap <Leader>l <Plug>(ale_toggle_buffer) <CR>
nnoremap ]a <Plug>(ale_next_wrap)
nnoremap [a <Plug>(ale_previous_wrap)
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

" Python Language Server: {{{ 3
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

" }}}

" Plugins: {{{ 2

if !has('nvim')
    " Invoke while in Vim by putting your cursor over a word and run <Leader>k
    runtime! ftplugin/man.vim
    let g:ft_man_folding_enable = 0
    setlocal keywordprg=:Man

    set runtimepath+='~/.config/nvim/after'
endif

runtime! macros/matchit.vim

" FZF: {{{ 3

if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

augroup fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

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

let g:fzf_history_dir = '~/.local/share/fzf-history'

" Between this and FZF.vim you have :Ag and :grep using ag, you should be fine
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
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
" Default: `'%code: %%s'`
let g:ale_echo_msg_format = '%linter% - %code: %%s %severity%'
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 1000
" }}}

" Devicons: {{{ 3
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1               " adding the flags to NERDTree
let g:airline_powerline_fonts = 1
" }}}

" Vim_Startify: {{{ 3
let g:startify_session_sort = 1
" }}}

" Ultisnips: {{{ 3
let g:UltiSnipsSnippetDir = [ '~/.config/nvim/UltiSnips' ]
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnips_python_quoting_style = 'GOOGLE'
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsEditSplit = 'vertical'
" }}}

" Gruvbox: {{{ 3
" Load the colorscheme last. Noticeable startuptime improvement
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
" }}}

" Language Client: {{{ 3
" A better way of doing this would be to check if the server is executable
" so like if executable('pyls) | let g:pyserver = 'pyls' and then run as
" many checks as you feel like typing and then append them all to this dict
let g:LanguageClient_serverCommands = {
    \ 'python': [ 'pyls' ]
    \ }
" }}}

" }}}

" Filetype Specific Options: {{{ 2

augroup ftpersonal
" IPython:
au BufRead,BufNewFile *.ipy setlocal filetype=python
" Web Dev:
au filetype javascript,html,css setlocal shiftwidth=2 softtabstop=2 tabstop=2
" Markdown:
autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
augroup end
" }}}

" Functions: {{{ 2

" Next few are from Junegunn so credit to him
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

"command to filter :scriptnames output by a regex
command! -nargs=1 Scriptnames call <sid>scriptnames(<f-args>)
function! s:scriptnames(re) abort
    redir => scriptnames
    silent scriptnames
    redir END

    let filtered = filter(split(scriptnames, "\n"), "v:val =~ '" . a:re . "'")
    echo join(filtered, "\n")
endfunction

function! s:helptab()
    if &buftype == 'help'
        wincmd T
        nnoremap <buffer> q :q<cr>
    endif
endfunction
" keeps erroring idk why.
" autocmd vimrc BufEnter *.txt call s:helptab()

function! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfunction

command! -bang Autosave call s:autosave(<bang>1)

" Whats the syntax group under my cursor?
function! s:hl()
  " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" }}}

" }}}
