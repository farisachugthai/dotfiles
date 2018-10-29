#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show every site package installed on a system.

Assumes::
    Unix OS

Will be tested on Win10 soon.
The only changes that should need to be made is possibly making a getter for
the home dir.
.. code block::
    >>> try:
    >>>     home = os.environ.get('$HOME')
    >>> except OSError:
    >>>     os.environ.get('%userprofile%')

Idk what the fallback is if those don't work. I suppose just crashing.

Also might wanna accept sys.argv in case we don't wanna exclusively
use ~/virtualenvs
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
