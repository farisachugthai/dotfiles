#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show every site package installed on a system.

Assumes::
    Unix OS

Will be tested om Win10 soon.
"""
from glob import glob
import os

search = "~/virtualenvs/**/lib/site-packages/**"
for i in glob(search):
    if "dist-info" not in i:
        print(i)
