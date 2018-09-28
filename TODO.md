# TODO

Didn't wanna resort to a TODO for a dotfiles repo...
But the 2 main branches are still quite different.

09/19/18 {possibly}:
Termux needs to:
~~git checkout Ultisnips/all.snippets~~

***************Come back to see if the above rendered correctly!***************

git checkout .Xresources
git checkout ptpython/config
git checkout everything in .ipython.
The main config is mostly style but there's also around 40 aliases,
and the keybindings file has a lot of notes.

Sep 23, 2018:

According to last ctime, the above should be from 09/19. Oh well if it's not.
Termux needs to:
git checkout .gitignore


Sep 27, 2018
Here's an out there idea. I just got the gruvbox theme for Atom.

At this location::
</home/faris/.atom/packages/gruvbox-plus-syntax/styles/schemes/dark.less>

We have a LESS file that shows what the RGB values are for things.
We have a couple of other files that provide overrides like at this file:
</home/faris/.atom/packages/gruvbox-plus-syntax/styles/schemes/dark-hard.less>

That defines
@background: #1d2021;
@foreground: #f9f5d7;

So couldn't we use this and define certain colors in our vimrc?
Then substitute those values in by saying nvim/after/syntax/markdown.vim

and override things that way?

We could even preview the colors because Atom has a color picker AND in MATE
we get MATE color selection!!!

I like this a lot.
