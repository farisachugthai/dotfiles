#!/usr/bin/env python3
# Maintainer: Faris Chugthai

import os
import sys

home = os.path.join(os.path.expanduser("~"), "")
repo = os.path.join(home, "projects", "dotfiles", "unix", "")


def symlink_repo(file):
    '''
    Symlink the dotfiles if nothing exists in the home directory.

    Parameters:
        file --> A relative pathname that starts at the base of the Unix folder
        in the repo

    Returns:
        None
    '''

    src = os.path.join(repo, file)
    dest = os.path.join(home, file)
    try:
        os.symlink(src, dest)
    except FileExistsError:
        if os.path.islink(dest):
            print("Sorry but a symlink to {0} already exists".format(dest))
        elif os.path.isfile(dest):
            print("Sorry but a file to {0} already exists".format(dest))
            # TODO: Verbosely backup the file and proceed
            # Use similar logic from backup-nt-posix.py


def main():
    '''
    Clone dotfiles to a user's home directory and then symlink to the repo.
    Maintained by Faris Chugthai
    '''

    if os.uname()[0] not in ["Darwin", "Linux"]:
        raise OSError("This script assumes a Unix operating system.")
        sys.exit()

    # Ensure all required dirs exist and if not create them
    cwd = os.getcwd()
    os.chdir(repo)
    for root, dirs, files in os.walk("."):
        # The "." path separator gets prepended to the link so splice it
        root = root[2:]
        if not os.path.isdir(root):
            os.makedirs(root, exist_ok=True)

        # Call for every file in the repo to be symlinked
        for rel_pathname in files:
            symlink_repo(os.path.join(root, rel_pathname))

    os.chdir(cwd)


if __name__ == '__main__':
    main()
