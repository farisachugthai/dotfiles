#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Rehash immediately to add everything in `$PATH` as a line alias.

:File: 01_rehashx.py
:Author: Faris Chugthai
:Github: https://github.com/farisachugthai
:date: |date|

This is an incredible little gem I just ran into, and hugely useful for
making IPython work as a more versatile system shell.

Help
-----
Help on method run_line_magic in  :mod:`IPython.core.interactiveshell`:

    run_line_magic(magic_name, line, _stack_depth=1)
    method of IPython.terminal.interactiveshell.TerminalInteractiveShell instance
    Execute the given line magic.


Parameters
----------
``magic_name`` : str
Name of the desired magic function, without '%' prefix.

``line`` : str
The rest of the input line as a single string.

``_stack_depth`` : int
If :func:`run_line_magic()` is called from :func:`magic()` then
``_stack_depth`` = 2. This is added to ensure backward compatibility for use of
:func:`get_ipython().magic()`


Usage
------
As the help outlines above, the second required positional argument to
:func:`run_line_magic` is ``line``. This is more easily understood as
'remaining arguments to the magic'. ``%rehashx`` takes none, but leaving it
blank causes the function call to raise an error, so an empty str
is provided.


.. todo::

    Figure out how to add ``%l`` to the end of every rehashed alias because
    nothing takes arguments now.

"""
from IPython import get_ipython

if __name__ == "__main__":
    ip = get_ipython()
    ip.run_line_magic('rehashx', '')
