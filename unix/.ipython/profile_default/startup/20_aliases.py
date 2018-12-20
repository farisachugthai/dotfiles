#  !/usr/bin/env python
#  -*- coding: utf-8 -*-
"""Aliases for the interactive shell.

For some reason there's no section about aliases in the skel file. Weird.
Well here's a fun fact!
You can use the %l specifier in an alias definition to represent the
whole line when the alias is called.  For example:

ipython::

   In [2]: alias bracket echo "Input in brackets: <%l>"
   In [3]: bracket hello world
   Input in brackets: <hello world>

Note that we quote when in the configuration file but when running alias
interactively the syntax %alias alias_name cmd doesn't require quoting.

Dec 16, 2018:

    Got this file working. No idea whether it's a better idea to iterate over
    the whole tuple like this but I can optimize at a different point in time.
    It's no longer cluttering up my ipython_config.py file and that's a win.

.. todo::

    Start implementing checks. Aliases like apt, dpkg and cd are platform
    specific. This isn't typically a problem but I can't imagine it'd be an
    expensive operation to do something like the following::

        >>> from platform import machine
        >>> machine.uname()

    Or whatever the syntax is.
"""
from IPython import get_ipython

ip = get_ipython()

if type(ip) is None:
    raise Exception

ip.alias_manager.user_aliases = [
      ('ag', 'ag --hidden --color'),
      ('apt', 'apt'),
      ('chmod', 'chmod'),
      ('conda', 'conda'),
      ('cp', 'cp -iv'),       # cp mv mkdir and rmdir are all overridden
      ('ctags', 'ctags'),     # it's nice to be able to build tags while working
      ('dpkg', 'dpkg'),
      ('echo', 'echo -e'),
      ('find', 'find'),
      ('fd', 'fd'),
      ('fzf', 'fzf'),         # all we need to do is figure out keybindings
      ('g', 'git status -sb'),
      ('ga', 'git add'),
      ('gch', 'git checkout'),
      ('gco', 'git commit'),
      ('gd', 'git diff'),
      ('gds', 'git diff --staged'),
      ('gds2', 'git diff --staged --stat'),
      ('git', 'git'),
      ('git hist', 'git log --pretty=format:%h %ad | %s%d [%an] --graph --date=short'),
      ('git last', 'git log -1 HEAD'),
      ('git staged', 'git diff --cached'),
      ('git unstage', 'git reset HEAD'),
      ('git unstaged', 'git diff'),
      ('glo', 'git log'),
      ('gp', 'git pull'),
      ('gpip', 'export PIP_REQUIRE_VIRTUALENV=0; pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'),
      ('gs', 'git status'),
      ('gst', 'git diff --stat'),
      ('head', 'head -n 30'),
      ('la', 'ls -AF --color=always'),
      ('l', 'ls -CF --color=always'),
      ('ll', 'ls -AlF --color=always'),
      ('ls', 'ls -F --color=always'),
      ('lt', 'ls -Altcr --color=always'),
      ('mk', 'mkdir -pv %l && cd %l'),      # check if this works. only mkdir
      ('mkdir', 'mkdir -pv'),
      ('mv', 'mv -iv'),
      ('nvim', 'nvim'),
      ('rg', 'rg'),
      ('rm', 'rm -v'),
      ('rmdir', 'rmdir -v'),
      ('profile_default', 'cd ~/projects/dotfiles/unix/.ipython/profile_default/startup'),
      ('startup', 'cd ~/projects/dotfiles/unix/.ipython/profile_default/startup'),
      ('tail', 'tail -n 30'),
      ('touch', 'touch'),
      ('tree', 'tree'),
      ('treea', 'tree -a I .git -I __pycache__'),
      ('vi', 'vim'),
      ('vim', 'vim'),
      ('xx', 'quit'),       # this is a sweet one
      ('..', 'cd ..'),
      ('...', 'cd ../..'),
    ]

if __name__ == "__main__":
    for i in ip.alias_manager.user_aliases:
        ip.alias_manager.define_alias(i[0], i[1])
