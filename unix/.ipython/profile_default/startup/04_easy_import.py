#!/usr/bin/env python
# -*- coding: utf-8 -*-
# flake8: noqa
"""Import my most frequently used modules.

Then imports a few utility functions from IPython and imports the python
package neovim is served in aka :mod:`pynvim`.

Here's a little bit more info.

.. code-block:: rst

    Help on module IPython.utils.dir2 in IPython.utils:


        NAME
        IPython.utils.dir2 - A fancy version of Python's builtin :func:`dir`
        function.

        FUNCTIONS

            dir2(obj)
            dir2(obj) -> list of strings

            Extended version of the Python builtin dir(), which does a few extra
            checks.

            This version is guaranteed to return only a list of true strings,
            whereas :func:`dir()` returns anything that objects inject into
            themselves, even if they
            are later not really valid for attribute access (many extension
            libraries have such bugs).

            get_real_method(obj, name)
            Like getattr, but with a few extra sanity checks:

            - If obj is a class, ignore everything except class methods
            - Check if obj is a proxy that claims to have all attributes
            - Catch attribute access failing with any exception
            - Check that the attribute is a callable object

            Returns the method or None.

            safe_hasattr(obj, attr)
            In recent versions of Python, hasattr() only catches AttributeError.
            This catches all errors.

        FILE

            `/usr/lib/python3.7/site-packages/IPython/utils/dir2.py`_

**2018-09-06**

.. note::

    Discovered that putting the imports into functions and calling those
    functions causes the imports to stay local to that function and not
    appear in the REPL namespace. Seemingly obvious now. So how does
    ptipython import things?

    You have access to ip.cleanup() after you import get_ipython
    Well it embeds ipython. But it has to import other modules. Hm.

"""
from importlib import import_module
import os
from pathlib import Path
import shutil
import subprocess
import sys

import IPython

from IPython.utils.dir2 import dir2, get_real_method, safe_hasattr
from IPython.core.interactiveshell import InteractiveShell

try:
    import git
except ImportError:
    pass


def _import_nvim(mod):
    """Import the neovim module.

    Utilizes :func:`import_module` from :mod:`importlib`.

    :param mod: A module to import.
    :returns: None
    """
    try:
        import_module(mod)
    except ImportError:
        print("************************************************************")
        print("{} import failed. Only ignore this if you plan on going"
              " the entire session without using %edit".format(mod))
        print("************************************************************")


if __name__ == "__main__":
    if sys.version_info > (3, 5):
        mod = 'pynvim'
    else:
        mod = 'neovim'

    _import_nvim(mod)
    del _import_nvim
