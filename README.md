# Dotfiles

A repository that hosts the dotfiles for my Ubuntu workstations and a Termux development environment.

### Termux:

1. Git clone the repository.
2. Run [symlink_repo.py](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/symlink_repo.py) to create directories and symlinks in appropriate sections of the user's home directory.
3. Run [initial_termux_install.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/initial_termux_install.sh) to obtain necessary packages. 

  - Termux comes with almost nothing out of the box, and as a result, packages such as findutils, file, sed, gawk, and grep must be installed by the user. 
  - This script will also execute [python_termux.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/python_termux.sh) which will download useful python applications like IPython, youtube-dl, flake8 and requests globally. 
  - It will also add a community repository that allows GCC, Jupyter Notebooks, and other packages to be downloaded.
