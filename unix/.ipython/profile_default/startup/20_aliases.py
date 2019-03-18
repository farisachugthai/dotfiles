#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""File for all shell aliases.

IPython Aliases
================

.. module:: aliases
    :synopsis: Create aliases for IPython to ease use as a system shell.

:File: 20_aliases.py
:Author: Faris Chugthai

`Github <https://github.com/farisachugthai>`_

Overview
---------
This module utilizes ``_ip``, the global
:class:`IPython.core.interactiveshell.InteractiveShell()` instance, and
fills the ``user_ns`` with common Linux idioms.


.. todo:: - Secondary todo. How do you expand an alias in rst?

That ``_ip`` you have there is a reference to the :class:`IPython.core.interactiveshell.InteractiveShell()`
global instance, and that's a serious PITA to type out every time.


String Formatting
------------------
When writing aliases, an alias definition can take various string placeholders.
As per the official documentation

.. topic:: %l parameter

    You can use the `%l` specifier in an alias definition to represent the
    whole line when the alias is called.


.. ipython::

    In [2]: alias bracket echo "Input in brackets: <%l>"
    In [3]: bracket hello world
    Input in brackets: <hello world>


Note that we quote when in the configuration file but when running ``alias``
interactively the syntax ``%alias alias_name cmd`` doesn't require quoting.


Attributes
-----------
``_ip`` : :class:`IPython.core.interactiveshell.InteractiveShell()`
    A global object representing the active :mod:`IPython`
    session. Contains varying packages as well as the
    current global namespace. Doesn't need to be defined
    in advance during an interactive session.


See Also
---------
Aliases file for IPython.
:ref:`IPython.core.alias.Alias`

"""
import platform

from IPython import get_ipython


def windows_specific_aliases(_ip):
    """Add Windows specific aliases to the ``user_ns``.

    Default Aliases On Windows
    ---------------------------
    .. ipython::

        In [42]: _ip.alias_manager.default_aliases
        Out[42]:
        [
            ('ls', 'dir /on'),
            ('ddir', 'dir /ad /on'),
            ('ldir', 'dir /ad /on'),
            ('mkdir', 'mkdir'),
            ('rmdir', 'rmdir'),
            ('echo', 'echo'),
            ('ren', 'ren'),
            ('copy', 'copy')
        ]

    ConEmu
    ------
    To a beautiful extent, ConEmu {and the Cmder package I have installed} gives
    the standard GNU tools.

    ``ls`` runs natively on my Windows 10 laptop from cmd! As a result I may
    move a few unexpected commands into the common_aliases function.

    In the future, it should be dynamically checked whether the user is
    starting up from a shell that has these commands loaded or not.


    Parameters
    -----------
    ``_ip`` : :class:`IPython.core.interactiveshell.InteractiveShell()` object
        The global instance of the current :mod:`IPython` shell.


    Returns
    --------
    ``ip.alias_manager.user_aliases` : List of tuples.
        Even though it may superficially appear to be a :mod:`traitlets` object,
        the interface is the same as a list with a tuple containing 2 elements
        each. Each element in the list takes the form (alias, system command).
        Therefore the type appears to be a list of tuples where each tuple
        contains 2 strings.

    """
    _ip.alias_manager.user_aliases = [
        ('copy', 'copy'),
        ('ddir', 'dir /ad /on'),
        ('echo', 'echo'),
        ('ldir', 'dir /ad /on'),
        ('ls', 'dir /on'),
        ('mkdir', 'mkdir'),
        ('ren', 'ren'),
        ('rmdir', 'rmdir'),
        (
            'tree',
            'tree /F /A %l',
        ),
    ]
    return _ip.alias_manager.user_aliases


def linux_specific_aliases(_ip):
    r"""Add Linux specific alias to the ``user_ns``.

    For the time being everything is getting thrown in here until I more
    accurately tease out what is a Linux built-in, 3rd party software, and
    which commands overlap between bash, cmd and powershell.

    Parameters
    -----------
    ``_ip`` : :class:`IPython.core.interactiveshell.InteractiveShell()` object
        The global instance of the current IPython shell.


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
    --------
    ``ip.alias_manager.user_aliases`` : List of tuples
        Even though it may superficially appear to be a :mod:`traitlets` object,
        the interface is the same as a list with a tuple containing 2 elements
        each. Each element in the list takes the form (alias, system command).

    """
    _ip.alias_manager.user_aliases = [
        ('ag', 'ag --hidden --color %l'),
        ('cp', 'cp -iv %l'),
        ('dus', 'du -d 1 -h %l'),
        ('echo', 'echo -e %l'),
        ('gpip',
         'export PIP_REQUIRE_VIRTUALENV=0; pip %l; export PIP_REQUIRE_VIRTUALENV=1 > /dev/null'
         ),
        ('head', 'head -n 30 %l'),
        ('mk', 'mkdir -pv %l && cd %l'),  # check if this works. only mkdir
        ('mkdir', 'mkdir -pv %l'),
        ('mv', 'mv -iv %l'),
        ('rm', 'rm -v %l'),
        ('rmdir', 'rmdir -v %l'),
        ('profile_default',
         'cd ~/projects/dotfiles/unix/.ipython/profile_default'),
        ('startup',
         'cd ~/projects/dotfiles/unix/.ipython/profile_default/startup'),
        ('tail', 'tail -n 30 %l'),
        ('tre', 'tree -ashFC -I .git -I __pycache__ --filelimit 25'),
        ('tree', 'tree %l'),
        ('...', 'cd ../..'),
    ]
    return _ip.alias_manager.user_aliases


def common_aliases(_ip):
    """Temporarily only git aliases."""
    _ip.alias_manager.user_aliases = [
        ('g', 'git status -sb'),
        ('ga', 'git add %l'),
        ('gb', 'git branch -a %l'),
        ('gci', 'git commit'),
        ('gcl', 'git clone %l'),
        ('gcls', 'git clone --depth 1 %l'),
        ('gco', 'git checkout %l'),
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
        ('glo', 'git log %l'),
        ('gm', 'git merge %l'),
        ('gmt', 'git mergetool %l'),
        ('gp', 'git pull'),
        ('gpo', 'git pull origin'),
        ('gpom', 'git pull origin master'),
        ('gpu', 'git push'),
        ('gr', 'git remote -v'),
        ('gs', 'git status'),
        ('gst', 'git diff --stat %l'),
        ('la', 'ls -AF --color=always %l'),
        ('l', 'ls -CF --color=always %l'),
        ('ll', 'ls -AlF --color=always %l'),
        ('ls', 'ls -F --color=always %l'),
        ('lt', 'ls -Altcr --color=always %l'),
        ('nvim', 'nvim %l'),
        ('vi', 'nvim %l'),
        ('vim', 'nvim %l'),
        ('xx', 'quit'),  # this is a sweet one
        ('..', 'cd ..'),
    ]
    return _ip.alias_manager.user_aliases


if __name__ == "__main__":
    _ip = get_ipython()

    if type(_ip) is None:
        raise Exception

    user_aliases = []

    user_aliases = common_aliases(_ip)

    # Now let's get the Linux aliases
    if platform.uname() == 'Linux':
        user_aliases += linux_specific_aliases(_ip)

    elif platform.uname() == 'Windows_NT':
        user_aliases += windows_specific_aliases(_ip)

    for i in user_aliases:
        _ip.alias_manager.define_alias(i[0], i[1])

    # Clean up namespace but also don't crash if we didn't add a single alias.
    try:
        del i
    except NameError:
        pass
