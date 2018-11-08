#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show an example of how to create line and cell magics.

Unfortunately in it's current invocation this extension doesn't work.

Usage::
    %load_ext example

While not utilized here, a similar execution path can be utilized for
IPython.core.magic.cell_magic

Let's try importing the Magics class.

Ah I just read the src and it mentions quite a few things I did wrong.

We also need to import InteractiveShell.register_magic(class or instance)
So I had it spelled wrong.
"""
import sys
import time

# utilize jedi and run :Pyimport IPython.core.magic to see the src
from IPython.core.magic import Magics, magics_class, line_magic
from IPython.core.interactiveshell import InteractiveShell

@magics_class
class ExampleMagic(Magics):

    def __init__(self, shell=None, **kwargs):
        super(ExampleMagic, self).__init__(shell)

    @line_magic
    def time_printer(self):
        """An example of a line magic."""
        if sys.platform.startswith('win'):
            return time.clock()
        else:
            return time.time()


def load_ipython_extension(ip):
    """Load the extension in IPython."""
    ip.register_magic(ExampleMagic)
    ip.register_magic(time_printer)
