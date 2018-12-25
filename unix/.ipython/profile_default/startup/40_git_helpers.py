#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Export functions to ease IPython/git interactions.

File: 40_git_helpers.py
Author: Faris Chugthai
Email: farischugthai@gmail.com
Github: https://github.com/farisachugthai

Attributes:
-----------

    module_level_variables (type): Explanation and give an inline docstring
    immediately afterwards if possible

Example:
--------

Any example of how to use this module goes here:: sh

    $ python exampleofrst.py

.. todo::

    There is a gitpython module. We could try to import that and then work
    using it.
"""
from pathlib import Path
import subprocess
import sys


def git_touch():
    """Convenience function that creates a file and git add's it"""
    if len(sys.argv) < 2:
        sys.exit()
    else:
        fname = sys.argv[1]
        fobject = Path(fname)
        fobject.touch()
        subprocess.run(['git', 'add', fobject])
