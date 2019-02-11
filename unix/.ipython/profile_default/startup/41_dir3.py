#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Expand on the functions provided by :func:`dir()`

Dir3
======

.. module:: dir3

:File: 41_dir3.py
:Author: Faris Chugthai
:Github: https://github.com/farisachugthai

Background
-----------

:func:`dir()` is a phenomenal function for exploring both the global namespace
and the exported methods of an object.

However it can get incredibly messy, especially when :mod:`IPython` displays the
placeholder variables for every cell that has been run in the session. I.E.:

.. literal::

    _i
    _ii
    _iii
    _1
    _29
    ...

This causes an incredibly long output that's difficult to parse quickly at
best, and at worst, the output truncates and all valuable information is hidden.
This function attempts to avoid that by hiding all private and/or mangled
methods I.E. ones that begin with the characters ``_`` or ``__``.

It also takes inspiration from :ref:`IPython.utils.dir2.dir2()`.


Attributes
-----------

ip (InteractiveShell): A global object representing the active IPython
                       session. Contains varying packages as well as the
                       current global namespace. Doesn't need to be defined
                       in advance during an interactive session.

.. code-block:: rst

    .. ipython::

        In[1]: dir3()
        Out[1]: ...  # ELLIPSES

.. todo::

    - Show some example usage.
    - Should this function import or in any way be based off of dir2 via import?


"""
import sys


def dir3(args):
    """Filter unnecessary information from :func:`dir()` output.

    Parameters
    ----------
    args : (iterable)
    The object to inspect

    Returns
    --------
    None

    .. note::

        Should it return the filtered output to the caller?
        ... uh probably dude.

    """
    filtered = []
    for i in args:
        if not i.startswith('_'):
            print(i)
            filtered.append(i)

    return filtered



def _interactive():
    """Define a private method for interactive use instead of ifmain block."""
    args = sys.argv[:]
    if len(args) > 2:
        filtered = dir3(args)
    else:
        global_namespace = ip.user_global_ns.keys()
        filtered = dir3(global_namespace)
    return filtered


if __name__ == "__main__":
    # This should silence the error from flake about ip being used but not
    # defined
    from IPython import get_ipython
    ip = get_ipython()
