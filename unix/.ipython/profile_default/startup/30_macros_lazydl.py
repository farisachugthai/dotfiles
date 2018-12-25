#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Persistent macros and placing them in startupdir.

Admittedly though, it doesn't actually make much sense to structure
the file this way. Macros require all string input. So that's useful if the
source of our info is a string; however, in a persistent file, we can define
arbitrarily complex objects. So why limit ourselves to the string?
"""
from IPython.core.macro import Macro

lazydl = Macro("""
import requests

print('Usage: Provide a URL and a filename and a plaintext file will be \
       downloaded to your current working directory!')

url = input("URL: ")
fname = input("fname: ")
res = requests.get(url)
with open(fname, 'xt') as f:
    f.write(res.tex)
""")

del Macro
