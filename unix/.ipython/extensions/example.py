#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show an example of how to create line and cell magics.

Usage::
    load_ipython_extension(example)

Don't actually load these!

While not utilized here, a similar execution path can be utilized for
IPython.core.magic.cell_magic
"""
from IPython.core.magic import magics_class, line_magic

import sys
import time


@magics_class
class ExampleMagic():
    pass


@line_magic
def time_printer():
    """An example of a line magic."""
    if sys.platform.startswith('win'):
        return time.clock()
    else:
        return time.time()


def load_ipython_extension(ip):
    """Load the extension in IPython."""
    ip.register_magics(ExampleMagic)
    ip.register_magics(time_printer)
