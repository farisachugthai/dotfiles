#!/usr/bin/env python3
# Maintainer: Faris Chugthai

import os
import sys

home = os.path.join(os.path.expanduser("~"), "")
# TODO: could wrap in a try/except with expanduser(%HOME%)
repo = os.path.join(home, "projects", "dotfiles", "unix", "")


def symlink_repo(file):
    '''
    Symlink the dotfiles if nothing exists in the home directory.

    Parameters:
        file --> A relative pathname that starts at the base of the Unix folder
        in the repo

    Output:
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
            # TODO: Offer to backup the file and then proceed


def main():
    '''
    Clone dotfiles to a user's home directory and then symlink to the repo.
    Assumes Linux only because it has only been tested on Ubuntu and Termux.
    Maintained by Faris Chugthai
    '''

    if os.uname()[0] != 'Linux':
        raise OSError("This script assumes a Linux operating system.")
        sys.exit()

    for root, dirs, files in os.walk(repo):
        # Now lets do the folder check
        if not os.path.isdir(root):
            os.makedirs(root, exist_ok=False)

        # Call for every file in the repo to be symlinked
        rel_file = [os.path.join(root, file) for file in files]
        for rel_file in files:
            symlink_repo(rel_file)


if __name__ == '__main__':
    main()
