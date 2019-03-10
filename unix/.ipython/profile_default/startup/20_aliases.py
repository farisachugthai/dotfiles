#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""File for all shell aliases.

IPython Aliases
===============

.. module:: aliases
    :synopsis: Create aliases for :mod:`IPython` to ease use as a system shell.

:File: 20_aliases.py
:Author: Faris Chugthai

`Github <https://github.com/farisachugthai>`_


.. changelog:: Mar 03, 2019

    Moved git aliases into new :func:`common_aliases()`


Overview
--------
This module utilizes ``_ip``, the global IPython InteractiveShell instance, and
fills the ``user_ns`` with common Linux idioms.

.. admonition::

    This blows up on Windows10. You've been warned.

.. todo::

    - Separate the dictionary below into OS and machine specific dictionaries.
    - Run basic checks and only add to the user namespace if they match.
    - Secondary todo. How do you expand an alias in rst?
    - ``_ip`` is a reference to the :class:`IPython.core.InteractiveShell` global instance
    - It isn't the actual module name and as a result that reference isn't going to work.


Parameters
----------
When writing aliases, an alias definition can take various string placeholders.
As per the official documentation


.. topic:: %l parameter

    You can use the %l specifier in an alias definition to represent the
    whole line when the alias is called.


.. ipython::

    In [2]: %alias bracket echo "Input in brackets: <%l>"
    In [3]: bracket hello world
    Input in brackets: <hello world>

Note that we quote when in the configuration file but when running alias
interactively the syntax ``%alias alias_name cmd`` doesn't require quoting.


Attributes
----------
``_ip`` : InteractiveShell
    A global object representing the active IPython session.
    Contains varying packages as well as the current global namespace.
    Doesn't need to be defined in advance during an interactive session.


See Also
--------
Aliases file for IPython.
:ref:`IPython.core.alias.Alias`

"""
import platform

import IPython
from IPython import get_ipython


def _sys_check():
    """Check OS."""
    return platform.uname().system


def linux_specific_aliases(_ip):
    r"""Add Linux specific aliases.

    For the time being everything is getting thrown in here until I more
    accurately tease out what is a Linux built-in, 3rd party software, and
    which commands overlap between bash, cmd and powershell.

    Parameters
    ----------
    ``_ip`` : :class:`IPython.core.interactiveshell.InteractiveShell()` object
        The global instance of IPython.


    Below is the source code for the function that is invoked here.

    .. code-block:: python3

        def define_alias(self, name, cmd):
            \"\"\"Define a new alias after validating it.

            This will raise an :exc:`AliasError` if there are validation
            problems.
            \"\"\"
            caller = Alias(shell=self.shell, name=name, cmd=cmd)
            self.shell.magics_manager.register_function(caller, magic_kind='line',
                                                        magic_name=name)

    Returns
    -------
    ``_ip.alias_manager.user_aliases`` : SingletonConfigurable
        Subclass of the :class:`AliasManager()` ....I think. Generically
        referring to it as a :mod:`traitlets` object but the interface is the
        same as a tuple with 2 elements in the form (alias, system command).



    """
    _user_aliases = [
        ('ag', 'ag --hidden %l'),
        ('cp', 'cp -iv %l'),  # cp mv mkdir and rmdir are all overridden
        ('dus', 'du -d 1 -h %l'),
        ('echo', 'echo -e %l'),
        ('gpip',
         'export PIP_REQUIRE_VIRTUALENV=0; python -m pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'
         ),
        ('gpip2',
         'export PIP_REQUIRE_VIRTUALENV=0; python2 -m pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'
         ),
        ('gpip3',
         'export PIP_REQUIRE_VIRTUALENV=0; python3 -m pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'
         ),
        ('head', 'head -n 30 %l'),
        ('la', 'ls -AF --color=always %l'),
        ('l', 'ls -CF --color=always %l'),
        ('ll', 'ls -AlF --color=always %l'),
        ('ls', 'ls -F --color=always %l'),
        ('lt', 'ls -Altcr --color=always %l'),
        ('mk', 'mkdir -pv %l && cd %l'),  # check if this works. only mkdir
        ('mkdir', 'mkdir -pv %l'),
        ('mv', 'mv -iv %l'),
        ('rm', 'rm -v %l'),
        ('rmdir', 'rmdir -v %l'),
        ('profile_default',
         'cd ~/projects/dotfiles/unix/.ipython/profile_default/startup'),
        ('startup',
         'cd ~/projects/dotfiles/unix/.ipython/profile_default/startup'),
        ('tail', 'tail -n 30 %l'),
        ('tre', 'tree -ashFC -I .git -I __pycache__ --filelimit 25'),
    ]
    return _user_aliases


def common_aliases(_ip):
    r"""Add aliases common to all OSes.

    Parameters
    ----------
    ``_ip`` : :class:`IPython.core.interactiveshell.InteractiveShell()` object
        The global instance of IPython.


    Returns
    -------
    ``_ip.alias_manager.user_aliases`` : SingletonConfigurable
        Subclass of the :class:`AliasManager()` ....I think. Generically
        referring to it as a :mod:`traitlets` object but the interface is the
        same as a tuple with 2 elements in the form (alias, system command).


    """
    _user_aliases = [
        ('g', 'git diff --staged --stat -- HEAD'),
        ('ga', 'git add %l'),
        ('ga.', 'git add .'),
        ('gar', 'git add --renormalize %l'),
        ('gb', 'git branch -a %l'),
        ('gci', 'git commit %l'),
        ('gcia', 'git commit --amend %l'),
        ('gcid', 'git commit --date=%l'),
        ('gciad', 'git commit --amend --date=%l'),
        ('gcl', 'git clone %l'),
        ('gcls', 'git clone --depth 1 %l'),
        ('gco', 'git checkout %l'),
        ('gcob', 'git checkout -b %l'),
        ('gd', 'git diff %l'),
        ('gds', 'git diff --staged %l'),
        ('gds2', 'git diff --staged --stat %l'),
        ('gdt', 'git difftool %l'),
        ('gf', 'git fetch --all'),
        ('git', 'git %l'),
        ('git hist',
         'git log --pretty=format:%h %ad | %s%d [%an] --graph --date=short'),
        ('git last', 'git log -1 HEAD %l'),
        ('git staged', 'git diff --cached %l'),
        ('git rel', 'git rev-parse --show-prefix'),
        ('git root', 'git rev-parse --show-toplevel'),
        ('git unstage', 'git reset HEAD'),
        ('git unstaged', 'git diff %l'),
        ('gl', 'git log %l'),
        ('glo', 'git log --graph --decorate --abbrev --branches --all'),
        ('gls', 'git ls-tree'),
        ('gm', 'git merge --no-ff %l'),
        ('gmm', 'git merge master'),
        ('gmt', 'git mergetool %l'),
        ('gp', 'git pull --all'),
        ('gpo', 'git pull origin'),
        ('gpom', 'git pull origin master'),
        ('gpu', 'git push'),
        ('gr', 'git remote -v'),
        ('gs', 'git status'),
        ('gsh', 'git stash'),
        ('gshp', 'git stash pop'),
        ('gshl', 'git stash list'),
        ('gshd', 'git stash drop'),
        ('gshc', 'git stash clear'),
        ('gsha', 'git stash apply'),
        ('gst', 'git diff --stat %l'),
        ('gt', 'git tag --list'),
        ('lswitch', 'legit switch'),
        ('lsync', 'legit sync'),
        ('lpublish', 'legit publish'),
        ('lunpublish', 'legit unpublish'),
        ('lundo', 'legit undo'),
        ('lbranches', 'legit branches'),
        ('vi', 'nvim %l'),
        ('vim', 'nvim %l'),
        ('xx', 'quit'),  # this is a sweet one
        ('..', 'cd ..'),
        ('...', 'cd ../..'),
    ]
    return _user_aliases


if __name__ == "__main__":
    _ip = get_ipython()

    if not isinstance(_ip, IPython.terminal.interactiveshell.TerminalInteractiveShell):
        raise Exception

    user_aliases = []

    if _sys_check() == 'Linux':

        # Now let's get the Linux aliases.
        user_aliases += linux_specific_aliases(_ip)

        if platform.machine() == "aarch64":
            # user_aliases += termux_aliases(ip)
            pass

    user_aliases += common_aliases(_ip)

    for i in user_aliases:
        _ip.alias_manager.define_alias(i[0], i[1])

    del i, _sys_check
