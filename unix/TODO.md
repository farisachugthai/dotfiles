# TODO


**07-25-18**

HOLY SHIT DON'T RUN `xrdb .Xresources` YOUR TERMINAL IS NOW PRINTING LETTERS
THAT YOU CAN ONLY SEE IF YOU HIGHLIGHT THINGS WHAT THE FUCK.

Also where the hell did I set the colorscheme for urxvt i see gruvbox in
Xresources but it has this weird blue thing going on. ngl it looks awesome but
i'm quite confused.


Like idk what to tell you man. But when you  use dlink.py, ensure that it's only
llinking files. If you link directories [which python will allow] then when you
download shit using vim-plug it'll go into your dotfile repo, not the actual
folder.

.local files will end up there, its amess dude.

also why is  my bash_history truncating at like 1000 lines before wrapping back
around it usually can write WAY more than that. which factor is fucking up?
Histsize is 50000 and its at 29k and its only 1000 lines  man idkwtf is going on


holy fuck this is too frustrating. and i'm afraid to commit any of these changes
because nothing is stable but at the same time i don't want to keep not
committing anything.

**Older**

So I just shifted my Kubuntu setup to run i3 as the WM and urxvt as the shell.
Also trying to put i3wm on Termux. As a result a lot of changes are gonna be
coming, but I won't have time to work on it regularly. Here's the list.

Refactor init.vim and vimrc. This is going to take so long that it'd be a waste
to elaborate much for now. However, the ideal [and this genuinely might take the
better part of the year] is to get nvim to the point where it's just sourcing
the vimrc OR that i have nvim setup as an IDE-like editor and vim as the quic ,
flexible yet barebones backup.

IPython profiles for different situations. nox profile, autoload pylab profile
etc

fix urxvt because the colorscheme looks normal at first until you launch nvim

either rewrite dmenu or find something better

get comfortable with i3 but once you do i'm excited.

move the readme in this repo over to newbuntu. keep working on those scripts.

if you don't fix the colorscheme and get urxvt to where you want it, then fix
the borders around konsole i don't understand why i3wm has such a strong gtk
feel to it.

both tmux and i3 are scriptable. yet i have no scripts. write something in one
of them that does simple shit like make a window with  a split with ipython and
neovim in the correct environments. actually that'd be medium hard but w/e.

see which one is easier to work with and then make it a full scale thing.

or even use tmuxp for projects or w/e.

once you get to the poitn where your environment is setup as soon as you login,
you won't need conda activate base in your bashrc anymore. in addition you won't
need any user installed packages that aren't in venvs. perfect isolation and a
much more sustainable setup

both tmux and i3 are scriptable. yet i have no scripts. write something in one
of them that does simple shit like make a window with  a split with ipython and
neovim in the correct environments. actually that'd be medium hard but w/e.

see which one is easier to work with and then make it a full scale thing.

or even use tmuxp for projects or w/e.

once you get to the poitn where your environment is setup as soon as you login,
you won't need conda activate base in your bashrc anymore. in addition you won't
need any user installed packages that aren't in venvs. perfect isolation and a
much more sustainable setup
