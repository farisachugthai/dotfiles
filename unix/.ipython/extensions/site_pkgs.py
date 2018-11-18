#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Show site packages for different venvs installed on a system.

Assumes:
    Unix OS

Will be tested on Win10 soon.

The only changes that should need to be made is possibly making a getter for
the home dir.

.. code block::

    >>> try:
    >>>     home = os.environ.get('$HOME')
    >>> except OSError:
    >>>     os.environ.get('%userprofile%')

TODO:
    - Might wanna accept sys.argv in case we don't wanna exclusively
      use ~/virtualenvs
    - If no arguments given print usage info.
    - If argument all (or maybe --all?) is given print everything
    - Add >>> to code below.

References:
    IPython.core.interactiveshell
    Around lines 2300::

    #-------------------------------------------------------------------------
    # Things related to macros
    #-------------------------------------------------------------------------

    def define_macro(self, name, themacro):
        \"\"\"Define a new macro

        Parameters
        ----------
        name : str
            The name of the macro.
        themacro : str or Macro
            The action to do upon invoking the macro.  If a string, a new
            Macro object is created by passing the string to it.
        \"\"\"

        from IPython.core import macro

        if isinstance(themacro, str):
            themacro = macro.Macro(themacro)
        if not isinstance(themacro, macro.Macro):
            raise ValueError('A macro must be a string or a Macro instance.')
        self.user_ns[name] = themacro

"""
import argparse
import sys

from IPython.core.macro import Macro


def _parse_arguments():
    """Parse user input."""
    parser = argparse.ArgumentParser(description="__doc__")

    parser.add_argument(
        "site-packages",
        default=None,
        action='store_true',
        help="Paths to py venvs.")

    parser.add_argument(
        "-a",
        "-all",
        help="Print all site packages in ~/virtualenvs"
    )  # gonna need a path to the venv dir

    # Stolen from argparse lib ref.
    parser.add_argument(
        '--log',
        default=sys.stdout,
        type=argparse.FileType('w'),
        help='The file where the packages should be written. Defaults to'
        'stdout. ')

    return parser


def all_site_pkgs():
    """Display every package in site-packages."""
    pkgs = Macro("""
    from glob import glob
    from os.path import expanduser, join as pjoin

    home = expanduser('~')

    search = glob(pjoin(home, "virtualenvs", "**", "lib", "python3.6","site-packages", "**"))

    for i in search:
        if "dist-info" not in i:
            if os.path.isdir(i):        # don't print loose files
                print(i)
                """)
    return pkgs


if __name__ == "__main__":
    # Does ipy run these files or source them?
    # Let's put an ifmaun and see uf its still available
    parser = _parse_arguments()
    # if should
    # this causes ipy startup to err so moved here
    # doing so gives
    # AttributeError: 'Namespace' object has no attribute 'print_help'
    if len(sys.argv) == 1:
        # Too few arguments. We can't specify this using argparse alone, so we
        # have to manually check.
        parser.print_help()
        parser.exit()

    args = parser.parse_args()
    pkgs = all_site_pkgs()  # leave it in user_ns in case I want it for later.

    args.log.write('%s' % pkgs)
    args.log.close()
