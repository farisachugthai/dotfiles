/* vim: set syntax=md : */ 
#Vimrc Notes

This is a further explanation of my vimrc.
Houses some scrap notes and ethereal ideas I have while configuring my work.

Contains notes, links to github repos and cheatsheets and generally anything
that would take too much space up in the file itself.

Heres my old vimrc with notes on Vundle. 
 		+" plugins
		+" vundle
		+" from: https://github.com/VundleVim/Vundle.vim/blob/master/README.md
		+" if you need to reinstall, run these commands
		+" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		+"
		+"the following's required as stated in the github Quick Start
		+set nocompatible
		+filetype off
		+" set the runtime path to include Vundle and initialize
		+set rtp+=~/.vim/bundle/Vundle.vim
		+call vundle#begin()
		+" alternatively, pass a path where Vundle should install plugins
		+"call vundle#begin('~/some/path/here')
		+
		+" let Vundle manage Vundle, required
		+Plugin 'VundleVim/Vundle.vim'
		+Plugin 'vimwiki/vimwiki'
		+"Plugin 'vim-scripts/indentpython.vim'
		+Plugin 'nvie/vim-flake8'
		+"https://github.com/nvie/vim-flake8
		+"flake8 is a static syntax and style checker. wraps around pyflakes, pep8 and
		+"ned's MacCabe script [complexity checker]
		+Plugin 'davidhalter/jedi-vim'
		+"https://github.com/davidhalter/jedi-vim
		+"jedi-vim is a vim binding to the autocompletion library jedi
		+"run :help jedi-vim if you get confused
		+"Plugin 'ivanov/vim-ipython'
		+"https://github.com/ivanov/vim-ipython
		+Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
		+"https://powerline.readthedocs.io/en/latest/usage/other.html#vim-statusline
		+"
		+" cheat40 not actually managed by vundle
		+"$ cd .vim
		+"$ git clone https://github.com/lifepillar/vim-cheat40.git pack/bundle/start/cheat40
		+
		+"https://github.com/lifepillar/vim-cheat40/blob/master/Readme.md#cheat40-a-cheat-sheet-for-vim
		+"Cheat40 is a foldable extensible 40-column cheat sheet that you may open in Vim by pressing <leader>?
		+
		+" All of your Plugins must be added before the following line
		+call vundle#end()            " required
		+filetype plugin indent on    " required
		+" To ignore plugin indent changes, instead use:
		+"filetype plugin on
		+"
		+" Brief help
		+" :PluginList       - lists configured plugins
		+" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
		+" :PluginSearch foo - searches for foo; append `!` to refresh local cache
		+" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
		+"
		+" see :h vundle for more details or wiki for FAQ
		+" Put your non-Plugin stuff after this line
		+
		+

Here are the error messages displayed when running vimscript and py3 for the
Fugitive statusline.

```
".bashrc" 130L, 3565C                               ~
E15: Invalid expression: <%f %h%m%r%{fugitive#status~
Press ENTER or type command to continue             ~
py3eval('powerline.new_window()')<,1            Top ow()')%<%f %h%m%r%{fugitive#sta
tusline()}%=%-14.(%l,%c%V%) %P
Press ENTER or type command to continue
E15: Invalid expression: <%f %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%) %P
```
