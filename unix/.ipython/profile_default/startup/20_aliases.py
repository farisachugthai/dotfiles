#  !/usr/bin/env python
#  -*- coding: utf-8 -*-
""" commented out the whole mod
doesn't work if you simply copy paste the list over.
the variable is set correctly and we're not raising errors. its just
unfortunately not going into the actual shells namespace.

alias is running with bland defaults if we try to create an alias files.

so maybe this file needs to have a return value, or the user_aliases var
needs to merge into something idk

no it can't be that one it's literally because it's in a different file
and as a result namespace. goddamn this is a doozy.
"""

#  from IPython import get_ipython
#  from traitlets.config.configurable import Configurable

#  ip = get_ipython()

#  if type(ip) is None:
#      raise Exception

#  ip.alias_manager.user_aliases = [
#      ('ag', 'ag'),
#      ('cp', 'cp -iv'),       # cp mv mkdir and rmdir are all overridden
#      ('fzf', 'fzf'),         # all we need to do is figure out keybindings
#      ('ga', 'git add'),
#      ('gd', 'git diff'),
#      ('gs', 'git status'),
#      ('head', 'head -n 30'),
#      ('la', 'ls -alFh'),
#      ('l', 'ls -CF'),
#      ('ll', 'ls -AlF'),      # i like mine more so override theres
#      ('lt', 'ls -Altcr'),
#      ('mkdir', 'mkdir -pv'),
#      ('mv', 'mv -iv'),
#      ('rm', 'rm -v'),
#      ('rmdir', 'rmdir -pv'),
#      ('tail', 'tail -n 30'),
#      ('tree', 'tree'),
#  ]

# and honestly running that first import statement,
# dir(alias_mngr.alias_manager),
# and calling help() on everything below and you kinda don't need docs
# obviously it'd be better but
