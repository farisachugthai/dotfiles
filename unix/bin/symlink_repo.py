#!/usr/bin/env python3
# Objectives:
# Clone dotfiles to a user's home directory and then symlink to the repo.
# Assumes Linux only because it has only been tested on Ubuntuband Termux.
# Maintained by Faris Chugthai

import os
import sys


def symlink_repo(link):
    src = os.path.join(repo, link)
    dest = os.path.join(home, link)
    try:
        os.symlink(src, dest)
    except FileExistsError:
        if os.path.islink(dest):
            print("Sorry but a symlink to {0} already exists".format(dest))
        elif os.path.isfile(dest):
            print("Sorry but a file to {0} already exists".format(dest))


def main():
    if os.uname()[0] != 'Linux':
        raise OSError("This script assumes a Linux operating system.")
        sys.exit()

    os.chdir(repo)
    for root, dirs, files in os.walk("."):
        rel_paths = [(os.path.join(root, file)) for file in files]
        for link in rel_paths:
            symlink_repo(link)


if __name__ == '__main__':
    home = os.path.join(os.path.expanduser("~"), "")
    # TODO: could wrap in a try/except with expanduser(%HOME%)
    repo = os.path.join(home, "projects", "dotfiles", "unix", "")
    main()
    os.chdir(home)
    # TODO: Make a function that takes dirs from os.walk and
    # uses os.mkdir(dirs) to create them. should be a 1 line function
    # or 2 if you want console output
