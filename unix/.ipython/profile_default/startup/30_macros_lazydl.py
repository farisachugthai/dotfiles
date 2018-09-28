#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Persistenting stored macrosand placing them in startupdir."""
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
