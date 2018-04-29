#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ==============================================================================
#
#          FILE: mv_to_repo.py
#
#       OPTIONS: ---
#  REQUIREMENTS: python3.4+
#          BUGS: ---
#       CREATED: 2018 Apr 27
# LAST MODIFIED: 2018 Apr 29
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

    shutil.copy(rel_file, str(rel_file) + ".bak")
    # TODO: Check that the directory exists in the repo and if not make one!
    shutil.move(rel_file, str(repo) + filename)
    rel_file.symlink_to(repo + rel_file)


if __name__ == '__main__':

    filename = sys.argv(1) if len(sys.argv) else print("Takes one filename.")
    f = Path(filename) if filename.is_file else print("This is not a file.")
    # TODO: Figure out how to evaluate multiple statements on one else.
    # We also need to sys.exit() if filename.is_file is False.

    home = Path.home()
    repo = Path.join(home, "projects", "dotfiles", "unix", "")
    cwd = Path.cwd()
    rel_path = Path.relative_to(cwd, home)
    rel_file = Path.joinpath(rel_path, f)

    main(rel_file)
