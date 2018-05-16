#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Maintainer: Faris Chugthai

import sys
import shutil
from pathlib import Path
import os

# These need to be up here. In the if __name__ block they never get run.
# Even if we import something like repo_dir_check we still need a lot of these
# Just left off the ones that require user input [which we might not be guaranteed
# to get if imported
home = Path.home()
repo = Path.joinpath(home, 'projects', 'dotfiles', 'unix', '')
cwd = Path.cwd()
rel_path = Path.relative_to(cwd, home)
dest = Path.joinpath(repo, rel_path)


def sys_checks():
    """Checks that system requirements are met."""
    if sys.version_info < (3, 4):
        sys.exit("Requires Python3.4 and up")

    if os.uname()[0] not in ["Darwin", "Linux"]:
        raise OSError("This script assumes a Unix operating system.")
        sys.exit()


def repo_dir_check():
    """
    Checks that the directory is in the repository and make one otherwise.
    """

    if dest.is_dir() is not True:
        #  https://docs.python.org/3/library/pathlib.html#pathlib.Path.mkdir
        # To mimic behavior of mkdir -p, use flags parents=True and exists_ok=True
        dest.mkdir(parents=True, exist_ok=True)


def main():
    """
    Backs up a file, moves it to the dotfiles repo and symlinks it.
    Currently moves file to hardcoded path but could be modified to take as an
    argument.

    Parameters:
        Name of file to backup, move and symlink.

    Assumes:
        User runs the script from inside the folder of the file they want to
        move. As a result a pathname cannot be given to a file.
    """

    if src.is_file() is not True:
        sys.exit("This is not a file. Aborting.")

    sys_checks()
    repo_dir_check()

    shutil.copy(str(src), str(src) + ".bak")

    shutil.move(str(src), str(dest))
    src.symlink_to(dest_file)


if __name__ == '__main__':
    # It might be smarter to change this list comprehension into a try except block
    # Actually that's definitely better because if we generalize this to where it
    # takes a different path as the destination repo we need a full block
    inputted = sys.argv[1] if len(sys.argv) == 2 else print("Takes one filename.")
    src = Path(inputted)
    dest_file = Path.joinpath(dest, sys.argv[1])

    main()
