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
    You have access to ip.cleanup() after you import get_ipython
    Well it embeds ipython. But it has to import other modules. Hm.
    However we're functional so take that to mean what you want! :D
"""
import os
from pathlib import Path
import re
import sqlite3
import sys

try:
    import pynvim
except ImportError as e:
    print("***************************************************************")
    print(e)
    print("pynvim import failed. Only ignore this if you plan on going"
          " the entire session without using %edit")
    print("***************************************************************")

# Nov 04, 2018: Let's add a few ipy :funcs: that have proven to be useful
from IPython.utils.dir2 import dir2     # simply because its a nicer dir2
from IPython import get_ipython
from IPython.core.interactiveshell import InteractiveShell
