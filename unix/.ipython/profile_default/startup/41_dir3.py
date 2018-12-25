#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Expand on the functions provided by dir()

dir() is a phenomenal function for exploring both the global namespace and
the exported methods of an object.

However it can get incredibly messy, especially when ipython displays the keys
for every line that has been run in the session. I.E.:
    _i
    _ii
    _iii
    _1
    _29
    ...

This causes an incredibly long output that's difficult to parse quickly. This
function attempts to avoid that.

File: 41_dir3.py
Author: Faris Chugthai
Email: farischugthai@gmail.com
Github: https://github.com/farisachugthai

Attributes:

    ip (InteractiveShell): A global object representing the active IPython
    session. Contains varying packages as well as the current global namespace.

.. code-block:: rst

    .. ipython::

        In[1]: dir3()
        Out[1]: ...  # ELLIPSES

.. todo::

    Did I do the doctest thing write? How you can use ellipses to ensure
    a doctest doesn't fail because of something that'll always vary at runtime?

"""


def dir3():
    """Filter some of dir's output."""
    ns = ip.user_global_ns.keys()
    for i in ns:
        if not i.startswith('_'):
            print(i)

    del ns
