#!/usr/bin/env python
# Maintainer: Faris Chugthai

# TODO: Generalize this script to accept arguments instead of hard coded paths.
# Accomplish this by breaking each step down into smaller pieces.

import os
import sys

home = os.path.join(os.path.expanduser("~"), "")
repo = os.path.join(home, "projects", "dotfiles", "unix", "")


def symlink_repo(src):
    '''
    Symlink the dotfiles if nothing exists in the home directory.

    Parameters:
        file --> A relative pathname that starts at the base of the Unix folder
        in the repo

    Returns:
        None
    '''

    src = os.path.join(repo, src)
    dest = os.path.join(home, src)
    try:
        os.symlink(src, dest)
    except FileExistsError:
        if os.path.islink(dest):
            pass
        elif os.path.isfile(dest):
            print("Sorry but a file to {0} already exists".format(dest))
# TODO: suggest to backit up and make the symlink


def main():
    '''
    Clone dotfiles to a user's home directory and then symlink to the repo.
    Maintained by Faris Chugthai
    '''

    if os.uname()[0] not in ["Darwin", "Linux"]:
        raise OSError("This script assumes a Unix operating system.")
        sys.exit()

    for root, dirs, files in os.walk(repo):
        if not os.path.isdir(root):
            os.makedirs(root, exist_ok=True)

        # Call for every file in the repo to be symlinked
        for src in files:
            symlink_repo(os.path.join(root, src))


if __name__ == '__main__':
    main()
