#!/usr/bin/env python
# Maintainer: Faris Chugthai
# Deleted the 3 off because this might be 2.7 compliant! 
# Well there's still the print statements. from __future__ import print

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
        # gonna need to learn what this command returns at some point so that we can figure out how to write the return value to a logfile. probably just returns 0 right?
    except FileExistsError:
        if os.path.islink(dest):
            # TODO: Learn logging methods and write to that. Probably wanna do
            # something to the effect of 'make note of every symlink that's 
            # created and everything that's already a file because if it's a 
            # link we don't care we did our job right? But if it's a file then 
            # we never moved it. 
            # print("Sorry but a symlink to {0} already exists".format(dest))
            pass
        elif os.path.isfile(dest):
            print("Sorry but a file to {0} already exists".format(dest))


def main():
    '''
    Clone dotfiles to a user's home directory and then symlink to the repo.
    Maintained by Faris Chugthai
    '''

    if os.uname()[0] not in ["Darwin", "Linux"]:
        raise OSError("This script assumes a Unix operating system.")
        sys.exit()

    for root, dirs, files in os.walk(repo):
        # The "." path separator gets prepended to the link so splice it
        root = root[2:]
        if not os.path.isdir(root):
            os.makedirs(root, exist_ok=True)

        # Call for every file in the repo to be symlinked
        for src in files:
            symlink_repo(os.path.join(root, src))


if __name__ == '__main__':
    main()
