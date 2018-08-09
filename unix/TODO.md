# TODO

**08-03-18** 

Tmux isn't sourcing profile at all anymore fuck. 

I odn't think it is on termux either otherwise i can't explain the lack of bash
completions

**07-25-18**

## X

HOLY SHIT DON'T RUN `xrdb .Xresources` YOUR TERMINAL IS NOW PRINTING LETTERS
THAT YOU CAN ONLY SEE IF YOU HIGHLIGHT THINGS WHAT THE FUCK.

### urxvt

Also where the hell did I set the colorscheme for urxvt i see gruvbox in
Xresources but it has this weird blue thing going on. ngl it looks awesome but
i'm quite confused.

Yeah the color issues you're having are 100% urxvt because nvim inside of tmux
is rendering both colors and the lil icons in your tmux statusline, p[for the
most part] flawlessly. couple of blips here and there but NOTHING like how bad
things are in urxvt.

so. i guess get that shit under control.

HOLY FUCK. STOP THE PRESSES EVERYONE CHECK THIS OUT!

https://github.com/muennich/urxvt-perls/tree/master/deprecated#clipboard

Dude urxvt natively supports copy paste i don't need A) some weird keybindings
and B) don't need a fucking plugin. I might end up dropping this shell ya know.

Like it's fun and also engaging to learn about the X server and super old linux
fun facts but i gotta learn something useful if i put this much time into it.

## Newbuntu in general

Like idk what to tell you man. But when you  use dlink.py, ensure that it's only
llinking files. If you link directories [which python will allow] then when you
download shit using vim-plug it'll go into your dotfile repo, not the actual
folder.

.local files will end up there, its a mess dude.

It's a relatively easy fix as well, but A) you have to fix it so it doesn't link
directories and then the much more complicated topic of B) do you want to
symlink the ENTIRE repo? Files like bashrc and profile are gonna exist you can't
symlink them.



## Bash

also why is  my bash_history truncating at like 1000 lines before wrapping back
around it usually can write WAY more than that. which factor is fucking up?
Histsize is 50000 and its at 29k and its only 1000 lines  man idkwtf is going on

holy fuck this is too frustrating. and i'm afraid to commit any of these changes
because nothing is stable but at the same time i don't want to keep not
committing anything.


yeah dude you REALLY need to fix the thing with your profile because holy fuck
your path doesn't include ~/bin LIKE WHAT KIND OF BULLSHIT IS THAT

## Git

Well fuck now I committed everything but the .profile is the wrong one. I need
to revert it back to the file I was using previously. i accidentally commited
the stock one.

so go into ~/.cheat and in gitREADME make a note of which file you took the
notes ipreviously. i accidentally commited the stock one.

so fix that and then  go into ~/.cheat and in gitREADME make a note of which file
 you took the notes in


## Vim

Not a bad idea to quick skim some docs on vim-airline and vim-virtualenv they're
both relatively short and will help lean things up a lil

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

either rewrite dmenu or find something better
get comfortable with i3 but once you do i'm excited.
move the readme in this repo over to newbuntu. keep working on those scripts.

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
