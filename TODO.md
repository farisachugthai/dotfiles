# TODO

**11/01/18**

Kinda starting over again because I'm on a new OS.

We need to fix the URL so I think it'd be something to the effect of

`git remote set-url origin <url>`

Problem is i don't actually know why the URL is messed up [i need to input
usernames and passwords] which sounds like I did git clone and then cloned the
https URL and not the git: one. So check that out and fix it. Then there's probably a LOT i need to catch up on from termux branch.


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
