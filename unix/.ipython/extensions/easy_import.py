#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

    .. currentmodule:: easy_import
        :synopsis: Import commonly used modules into the IPython namespace.

:File: easy_import.py
:Author: Faris Chugthai

Attributes:
-----------
``mod_variables`` : type
    Explanation and give an inline docstring.

Example:
--------
Any example of how to use this module goes here.

.. code-block:: python3

    pass

.. any directives::

    example text


"""
from IPython import get_ipython
from IPython.utils.importstring import import_item


def load_ns(mods):
    """Load modules into the namespace.

    Parameters
    ----------
    mods : module(s)
        Modules to import.


    Returns
    -------
    None


    Examples
    --------
    %ns mpl


    """
    _ip = get_ipython()
    if not _ip.user_ns:
        _ip.user_ns = []
        # should probably check that this isn't empty after 20_aliases
        for mod in mods:
            if mod in aliases:
                _ip.user_ns.update(import_ns(namespaces[aliases[mod]]))


def load_ipython_extension(_ip):
    """Create ``ns`` magic."""
    ___ip.magics_manager.register_function(load_ns, 'line', 'ns')
