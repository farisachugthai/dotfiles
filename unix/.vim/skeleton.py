#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Short description of the module.

More detailed explanation of things.
Possible use cases.

Depends:

Around here would be an appropriate place to put:
    :copyright: (c) 2018 Faris Chugthai
    :license: MIT

"""

__author__ = 'Faris Chugthai'
__copyright__ = 'Copyright (C) 2018 Faris Chugthai'
__email__ = 'farischugthai@gmail.com'
__license__ = 'MIT'
__requires__ = 'flake8==3.5.0'
__url__ = 'https://github.com/farisachugthai'

class MyClass(object):

    """Docstring for MyClass. """

    def __init__(self, a, b, c):
        """TODO: to be defined1.

        :a: TODO
        :b: TODO
        :c: TODO

        """
        self._a = a
        self._b = b
        self._c = c

        pass            # code


def main(pos_args, kw_args, *args, **kwargs):
    """Put your summary of the function here.

    Provide a more detailed explanation if necessary. Returns and raises
    signatures are from pandas.core.checked_add_with_arr

    Parameters
    ----------
    var : type

    Returns
    -------
    sum : An array for elements x + b for each element x in arr if b is
          a scalar or an array for elements x + y for each element pair
          (x, y) in (arr, b).

    Raises
    ------
    OverflowError if any x + y exceeds the maximum or minimum int64 value.

    """
    pass


if __name__ == '__main__':
    main()
