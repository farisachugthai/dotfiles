#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Initialize the global IPython instance and begin configuring.

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

_ip = get_ipython()

logging.getLogger(__name__).addHandler(NullHandler())

pkg_resources.declare_namespace(__name__)

__path__ = extend_path(sys.path, __file__)
