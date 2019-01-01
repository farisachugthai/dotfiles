#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Automate downloads using requests.

Shouldn't be in startup as ipython not only sources but directly
executes all files in `$IPYTHON/.profile_default/startup`

:File: 30_macros_lazydl.py
:Author: Faris Chugthai
:Email: farischugthai@gmail.com
:URL: https://github.com/farisachugthai

Attributes:

    URL (str): Full URL of page to download. Either given as command is
    executed or user is prompted for such.

    fname (str): Path to save file.


Example:

        $ python 30_macros_lazydl.py -u https://github.com/user/repo/README.md -o ./doc/README.md

Assumes:

    Plaintext document.
"""
import argparse

import requests


def _parse_arguments():
    """Parse arguments."""
    parser = argparse.ArgumentParser(description='Download a plaintext file quickly'
                                          ' and easily.')

    parser.add_argument('-u', '--url', help='The URL to download.')

    parser.add_argument('-o', '--output', help='Where to download the file.')

    args = parser.parse_args()

    return args


def no_args():
    """Continue with the script even when improper number of args given."""
    print('Usage: Provide a URL and a filename and a plaintext file will be'
          ' downloaded to your current working directory!')

    url = input("URL: ")
    fname = input("fname: ")
    res = requests.get(url)
    with open(fname, 'xt') as f:
        f.write(res.text)


if __name__ == "__main__":
    args = _parse_arguments()

    if not args.url or not args.output:
        no_args()
