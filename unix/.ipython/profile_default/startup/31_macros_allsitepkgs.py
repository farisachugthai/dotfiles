#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show every site package installed on a system.

Assumes:
    Unix OS

Will be tested on Win10 soon.

The only changes that should need to be made is possibly making a getter for
the home dir.

.. code block::

    >>> try:
    >>>     home = os.environ.get('$HOME')
    >>> except OSError:
    >>>     os.environ.get('%userprofile%')

TODO:
    - Might wanna accept sys.argv in case we don't wanna exclusively
      use ~/virtualenvs
    - If no arguments given print usage info.
    - If argument all (or maybe --all?) is given print everything
"""
from IPython.core.macro import Macro

allsitepkgs = Macro("""
from glob import glob
from os.path import expanduser, join as pjoin

home = expanduser('~')

search = glob(pjoin(home, "virtualenvs", "**", "lib", "python3.6","site-packages", "**"))

for i in search:
    if "dist-info" not in i:
        if os.path.isdir(i):        # don't print loose files
            print(i)
            """)
