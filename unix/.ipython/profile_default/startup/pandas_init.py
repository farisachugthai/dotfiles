#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Initialize desired parameters for pandas at startup.

:URL: `https://realpython.com/python-pandas-tricks/#1-configure-options-settings-at-interpreter-startup`_
:File: pandas_init.py
:Author: Faris Chugthai
:Email: farischugthai@gmail.com
:Github: https://github.com/farisachugthai

"""
import sys

try:
    import pandas as pd
except ImportError:
    sys.exit()


def start():
    options = {
            'display': {
                'max_columns': None,
                'max_colwidth': 25,
                'expand_frame_repr': False,  # Don't wrap to multiple pages
                'max_rows': 30,
                'max_seq_items': 50,
                # Max length of printed sequence 'precision': 4,

                'show_dimensions': False
                },
            'mode': {
                'chained_assignment': None
                # Controls SettingWithCopyWarning
                }
            }

    for category, option in options.items():
        for op, value in option.items():
            pd.set_option(f'{category}.{op}', value)  # Python 3.6+


if __name__ == '__main__':
    start()

    del start
# Clean up namespace in the interpreter
