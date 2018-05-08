#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ==============================================================================
#
#          FILE: mv_to_repo.py
#
#       OPTIONS: ---
#  REQUIREMENTS: python3.4+
#          BUGS:
#       CREATED: 2018 Apr 27
# LAST MODIFIED: 2018 Apr 30
#    MAINTAINER: Faris Chugthai
# ==============================================================================

import sys
import shutil
from pathlib import Path


def main(rel_file):
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

    # Backup the file
    shutil.copy(src, str(src) + ".bak")

    # Check that the directory exists and make one otherwise
    dest = Path.joinpath(repo, rel_path)
    if dest.is_dir() is not True:
        #  https://docs.python.org/3/library/pathlib.html#pathlib.Path.mkdir
        # To mimic behavior of mkdir -p, use flags parents=True and exists_ok=True
        dest.mkdir(parents=True, exist_ok=True)

    # Didnt realize this. shutil requires strings as inputs because it utilizes rstrip to return files
    shutil.move(str(src), str(dest))
    dest_file = Path.joinpath(dest, sys.argv[1])
    src.symlink_to(dest_file)


if __name__ == '__main__':

    inputted = sys.argv[1] if len(sys.argv) == 2 else print("Takes one filename.")
    src = Path(inputted)
    if src.is_file() is not True:
        print("This is not a file. Aborting.")
        sys.exit()

    home = Path.home()
    repo = Path.joinpath(home, "projects", "dotfiles", "unix", "")
    cwd = Path.cwd()
    rel_path = Path.relative_to(cwd, home)
    rel_file = Path.joinpath(rel_path, src)

    main(rel_file)
