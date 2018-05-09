#!/usr/bin/env python3
# Maintainer: Faris Chugthai

import sys
import shutil
from pathlib import Path


def backup(src):
    """ Backs up a file before doing anything."""

    shutil.copy(str(src), str(src) + ".bak")
    # sys.exit("Error: File doesn't exist. Exiting...")


def strip_space(src):
    """ Strips all leading and trailing whitespace out of a file."""

    print("Clearing whitespace...")

    with src.open('r') as f:
        tmp = [line.rstrip() + '\n' for line in f]

    with src.open('w') as f:
            f.writelines(tmp)

    print("Done!")


def main():
    src = Path(sys.argv[1])
    backup(src)
    strip_space(src)


if __name__ == '__main__':
    main()
