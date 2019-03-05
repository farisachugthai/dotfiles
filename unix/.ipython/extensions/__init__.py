#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Let's make our test extension a package.

===============
Extensions Init
===============
Still wildly unsure of how to correctly initialize packages but stuff doesn't
break as often so that's a win?


Requires
---------
Python3 and IPython 7+


"""
import logging
from logging import NullHandler
from pkgutil import extend_path
import sys

import pkg_resources
from IPython import get_ipython

from .example import ExampleMagic

_ip = get_ipython()

logging.getLogger(__name__).addHandler(NullHandler())

pkg_resources.declare_namespace(__name__)

__path__ = extend_path(sys.path, __file__)

