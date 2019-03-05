#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Give a detailed, colored traceback and drop into pdb on exceptions."""
import sys


class ExceptionHook(BaseException):
    """Custom exception hook for IPython."""

    instance = None

    def __call__(self, *args, **kwargs):
        if self.instance is None:
            from IPython.core import ultratb
            self.instance = ultratb.FormattedTB(
                mode='Plain', color_scheme='Linux', call_pdb=1)
        return self.instance(*args, **kwargs)


sys.excepthook = ExceptionHook()
