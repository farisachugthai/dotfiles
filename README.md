# Dotfiles

A repository that hosts the dotfiles for my Ubuntu workstations and a Termux
development environment.

Most of the code here is helper code that aides my productivity while I'm
working on various personal projects.

Enjoy reading through the code, feel free to take anything that interests you,
and leave a comment or open an issue if you notice anything that you'd
personally improve!

## Features

Currently this houses code for dozens of applications with a focus on python
programming and conventional Unix terminal workflows.

In addition, global configurations for [git](./unix/.config/git)
and [Anaconda](./unix/.condarc) exist.

## IPython

I regularly use IPython as a system shell in comparison to the typical Bash
shell that Unix OSes provide. While a terminal provides a huge number of
powerful commands and the ability to pipe them together, Bash still has a number
of inconsistencies and oddities in its behavior.

As a result I've created a few [extensions](./unix/.ipython/extensions) and
written a few scripts that are run during IPython's initialization.

Those startup files are here: [startup](./unix/.ipython/profile_default/startup)
and you can check out the README where I detail the code here:

[README](./unix/.ipython/profile_default/startup/README.rst)

### Features

The first script to run invokes `%rehashx%` which initializes IPython
with all of the commands that the system shell knows.
