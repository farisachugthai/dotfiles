#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Short description of the module.

More detailed explanation of things.
Possible use cases.

Depends:

Below is the GPL with a fold marker. Feel free to close and delete.
GPL {{{
All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}}}

Below is the MIT license
MIT: {{{
All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}}}

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
