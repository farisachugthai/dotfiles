#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Initialize the global IPython instance and begin configuring.

Requires
---------
Python3 and IPython 7+

"""
import logging
from logging import NullHandler
import os
import sys

logging.getLogger(__name__).addHandler(NullHandler())

sys.path.append(os.path.abspath(os.path.dirname(__name__)))
