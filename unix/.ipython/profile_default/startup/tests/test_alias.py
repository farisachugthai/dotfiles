#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Test that the IPython alias manager works.

:File: test_alias.py
:Author: Faris Chugthai
:Email: farischugthai@gmail.com
:Github: https://github.com/farisachugthai

Took this from the IPython team insofar.

Should definitely consider rewriting it.
But like partially because plagariasm, partially
because wth is this saying?
"""
from IPython import get_ipython
from IPython.utils.capture import capture_output

import nose.tools as nt

_ip = get_ipython()


def test_alias_lifecycle():
    name = 'test_alias1'
    cmd = 'echo "Hello"'
    am = _ip.alias_manager
    am.clear_aliases()
    am.define_alias(name, cmd)
    assert am.is_alias(name)
    nt.assert_equal(am.retrieve_alias(name), cmd)
    nt.assert_in((name, cmd), am.aliases)

    # Test running the alias
    orig_system = _ip.system
    result = []
    _ip.system = result.append
    try:
        _ip.run_cell('%{}'.format(name))
        result = [c.strip() for c in result]
        nt.assert_equal(result, [cmd])
    finally:
        _ip.system = orig_system

    # Test removing the alias
    am.undefine_alias(name)
    assert not am.is_alias(name)
    with nt.assert_raises(ValueError):
        am.retrieve_alias(name)
    nt.assert_not_in((name, cmd), am.aliases)


def test_alias_args_error():
    """Error expanding with wrong number of arguments."""
    _ip.alias_manager.define_alias('parts', 'echo first %s second %s')
    # capture stderr:
    with capture_output() as cap:
        _ip.run_cell('parts 1')

    nt.assert_equal(cap.stderr.split(':')[0], 'UsageError')


if __name__ == "__main__":
    test_alias_lifecycle()
    test_alias_args_error()
