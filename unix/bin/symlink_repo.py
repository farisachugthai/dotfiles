#!/usr/bin/env python3
# Objectives:
# Clone my personal dotfiles to a user's home directory and then symlink to the
# repo.
# Assumes Linux only because currently it has only been tested on Ubuntu
# and Termux
# Maintained by Faris Chugthai

import os
import sys


def main():
    if os.uname()[0] != 'Linux':
        print("This script assumes a Linux operating system. I'm sorry but the\
        script will terminate now.")
        sys.exit()

    os.chdir(repo)
    for root, dirs, files in os.walk("."):
        rel_paths = [(os.path.join(root, file)) for file in files]
        for link in rel_paths:
            try:
                os.symlink(os.path.join(repo, link), os.path.join(home, link))
            except FileExistsError:
                if os.path.islink(os.path.join(home, link)):
                    print("Sorry but a symlink to {0} already exists".format(os.path.join(home, link)))
                elif os.path.isfile(os.path.join(home, link)):
                    print("Sorry but a file to {0} already exists".format(os.path.join(home, link)))


if __name__ == '__main__':
    home = os.path.join(os.path.expanduser("~"), "")
    # TODO: cpuld wrap in a try/except with expanduser(%HOME%)
    repo = os.path.join(home, "projects", "dotfiles", "unix", "")
    main()
    os.chdir(home)
    # TODO: Could refactor the entire try block into a function
    # TODO: Also could make a function that takes dirs from os.walk and
    # uses os.mkdir(dirs) to create them. should be a 1 line function
    # or 2 if you want console output
