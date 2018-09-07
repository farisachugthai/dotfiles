#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Import my most frequently used modules.

2018-09-06
Discovered that putting the imports into functions and calling those functions
causes the imports to stay local to that function and not appear in the REPL
namespace. Seemingly obvious now. So how does ptipython import things?

"""

import os
from pathlib import Path
import re
import sqlite3
import sys

try:
    import neovim
except ImportError as e:
    print(e)
    print("Neovim import failed. Only ignore this if you plan on going"
          " the entire session without using %edit")
