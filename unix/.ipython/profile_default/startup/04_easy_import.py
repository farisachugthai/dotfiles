#!/usr/bin/env python
# -*- coding: utf-8 -*-
# flake8: noqa
"""Import my most frequently used modules.

Imports built-in modules into the global namespace and noisely warns if 3rd
party modules aren't installed.

Usage:

    File is neither run nor interactively sourced.

.. notes 2018-09-06:
    Discovered that putting the imports into functions and calling those functions
    causes the imports to stay local to that function and not appear in the REPL
    namespace. Seemingly obvious now. So how does ptipython import things?

    Well it embeds ipython. But it has to import other modules. Hm.

    However we're functional so take that to mean what you want! :D

..todo:

    pynvim is the new module to import for neovim. However it only exists
    for python3.6 >. So we're gonna need to do a version check, then try
    to import pynvim for sys.version_info > (3, 5) ugh
"""
import os
from pathlib import Path
import shutil
import subprocess
import sys


def import_nvim(mod):
    """Import the neovim module."""
    try:
        import_module(mod)
    except ImportError as e:
        print("***************************************************************")
        print("{} import failed. Only ignore this if you plan on going"
              " the entire session without using %edit".format(mod))
        print("***************************************************************")

# Nov 04, 2018: Let's add a few ipy :funcs: that have proven to be useful
from IPython.utils.dir2 import dir2     # simply because its a nicer dir2
# from IPython import get_ipython this is imported in a couple different files
# so we don't actually need it here
from IPython.core.interactiveshell import InteractiveShell

if __name__ == "__main__":
    from importlib import import_module
    if sys.version_info > (3,5):
        mod = 'pynvim'
    else:
        mod = 'neovim'

    import_nvim(mod)
    del import_nvim
    del mod
