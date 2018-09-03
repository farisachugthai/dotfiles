#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Short description of the module.

More detailed explanation of things.
Possible use cases.

Depends:
    requests
    other 3rd party modules

Examples:
    >>> hopefully_functional_code()

Raises:


Returns:


Around here would be an appropriate place to put:
    :copyright: (c) 2018 Faris Chugthai
    :license: MIT

{Do we know and do we care what style docstring that is? Asking because
UltiSnips makes the distinction}

"""

__author__ = 'Faris Chugthai'
__copyright__ = 'Copyright (C) 2018 Faris Chugthai'
__email__ = 'farischugthai@gmail.com'
__license__ = 'MIT'
__requires__ = 'flake8==3.5.0'
__url__ = 'https://github.com/farisachugthai'


# For the class below can we take note of which docstrings are visible
# under what conditions? In the ipython shell if i run import MyClass; MyClass?
# or MyClass.__init__? what do I see? And how much more likel am I to run the
# first than the second AKA do we need an elaborate or really any docstring for
# __init__?
class MyClass(object):

    """Docstring for MyClass."""

    def __init__(self, a, b, c):
        """TODO: to be defined.

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

    """
    pass


if __name__ == '__main__':
    main()
