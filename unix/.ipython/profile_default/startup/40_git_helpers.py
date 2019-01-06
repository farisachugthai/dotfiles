#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Export functions to ease IPython/Git interactions.

:File: 40_git_helpers.py
:Author: Faris Chugthai
:Email: farischugthai@gmail.com
:Github: https://github.com/farisachugthai

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

try:
    from git import Git
except ImportError:
    pass


def git_touch():
    """Convenience function that creates a file and git add's it"""
    if len(sys.argv) < 2:
        sys.exit()
    else:
        fname = sys.argv[1]
        fobject = Path(fname)
        fobject.touch()
        subprocess.run(['git', 'add', fobject])


if __name__ == "__main__":
    git_touch()
    # The above is basically a placeholder. This should be run interactively
    # and will expose commands as necessary and give useful defaults and
    # prompts that guide users in the right direction to running a correct
    # command short of "read 170 different man pages"
