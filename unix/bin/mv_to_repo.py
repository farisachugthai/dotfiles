#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#          FILE: mv_to_repo.py
# LAST MODIFIED: 2018 Apr 30
#    MAINTAINER: Faris Chugthai

import sys
import shutil
from pathlib import Path
import os


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

    # Backup the file
    shutil.copy(str(src), str(src) + ".bak")

    # Didnt realize this. shutil requires strings as inputs because it utilizes rstrip to return files
    shutil.move(str(src), str(dest))
    src.symlink_to(dest_file)


if __name__ == '__main__':
    inputted = sys.argv[1] if len(sys.argv) == 2 else print("Takes one filename.")
    home = Path.home()
    repo = Path.joinpath(home, 'projects', 'dotfiles', 'unix', '')
    src = Path(inputted)
    cwd = Path.cwd()
    rel_path = Path.relative_to(cwd, home)
    dest = Path.joinpath(repo, rel_path)
    dest_file = Path.joinpath(dest, sys.argv[1])

    main()
