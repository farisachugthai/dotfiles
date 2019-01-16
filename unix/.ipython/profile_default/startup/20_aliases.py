#  !/usr/bin/env python
#  -*- coding: utf-8 -*-
"""File for all shell aliases.

Utilizes `ip`, the global interactive Ipython session. Fills the `user_ns`
with common Linux idioms.

.. note::

    Should I add a check that this a Unix OS because this'll blow up on NT?

Substitutions
-------------

You can use the ``%l`` specifier in an alias definition to represent the
whole line when the alias is called.  For example::

.. ipython::

   In [2]: alias bracket echo "Input in brackets: <%l>"
   In [3]: bracket hello world
   Input in brackets: <hello world>

Note that we quote when in the configuration file but when running alias
interactively the syntax ``%alias alias_name cmd`` doesn't require quoting
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
      ('du', 'du'),
      ('dus', 'du -d 1 -h'),
      ('echo', 'echo -e'),
      ('find', 'find'),
      ('fd', 'fd'),
      ('fzf', 'fzf'),         # all we need to do is figure out keybindings
      ('g', 'git status -sb'),
      ('ga', 'git add'),
      ('gb', 'git branch'),
      ('gba', 'git branch -a'),
      ('gci', 'git commit'),
      ('gcl', 'git clone'),
      ('gcls', 'git clone --depth 1'),
      ('gco', 'git checkout'),
      ('gd', 'git diff'),
      ('gds', 'git diff --staged'),
      ('gds2', 'git diff --staged --stat'),
      ('gdt', 'git difftool'),
      ('gf', 'git fetch --all'),
      ('git', 'git'),
      ('git hist', 'git log --pretty=format:%h %ad | %s%d [%an] --graph --date=short'),
      ('git last', 'git log -1 HEAD'),
      ('git staged', 'git diff --cached'),
      ('git rel', 'git rev-parse --show-prefix'),
      ('git root', 'git rev-parse --show-toplevel'),
      ('git unstage', 'git reset HEAD'),
      ('git unstaged', 'git diff'),
      ('glo', 'git log'),
      ('gm', 'git merge'),
      ('gmt', 'git mergetool'),
      ('gp', 'git pull'),
      ('gpip', 'export PIP_REQUIRE_VIRTUALENV=0; pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'),
      ('gpo', 'git pull origin'),
      ('gpom', 'git pull origin master'),
      ('gpu', 'git push'),
      ('gr', 'git remote'),
      ('grv', 'git remote -v'),
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
      ('tre', 'tree -ashF -I .git -I __pycache__'),
      ('vi', 'vim'),
      ('vim', 'vim'),
      ('xx', 'quit'),       # this is a sweet one
      ('..', 'cd ..'),
      ('...', 'cd ../..'),
    ]


if __name__ == "__main__":
    for i in ip.alias_manager.user_aliases:
        ip.alias_manager.define_alias(i[0], i[1])

    #  can't believe i forgot this
    del i
