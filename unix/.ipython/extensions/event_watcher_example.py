#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Interactively watch a variable.

Event Watcher
~~~~~~~~~~~~~~~~

Provided by the IPython development team as an example of the new
input parser for release 7.0!!!

URL::
    `<https://ipython.readthedocs.io/en/stable/config/callbacks.html#ipython-events>`

IPython Events:
Extension code can register callbacks functions which will be called on
specific events within the IPython code. You can see the current list of
available callbacks, and the parameters that will be passed with each, in the
callback prototype functions defined in IPython.core.events.
To register callbacks, use `IPython.core.events.EventManager.register().`

"""


class VarWatcher(object):

    def __init__(self, ip):
        self.shell = ip
        self.last_x = None

    def pre_execute(self):
        self.last_x = self.shell.user_ns.get('x', None)

    def pre_run_cell(self, info):
        print('Cell code: "%s"' % info.raw_cell)

    def post_execute(self):
        if self.shell.user_ns.get('x', None) != self.last_x:
            print("x changed!")

    def post_run_cell(self, result):
        print('Cell code: "%s"' % result.info.raw_cell)
        if result.error_before_exec:
            print('Error before execution: %s' % result.error_before_exec)

    def load_ipython_extension(ip):
        vw = VarWatcher(ip)
        ip.events.register('pre_execute', vw.pre_execute)
        ip.events.register('pre_run_cell', vw.pre_run_cell)
        ip.events.register('post_execute', vw.post_execute)
        ip.events.register('post_run_cell', vw.post_run_cell)
