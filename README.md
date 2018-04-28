# Dotfiles

A repository that hosts the dotfiles for my Ubuntu workstations and a Termux development environment.

Installation scripts have been included to assist in setup.


## Dependencies:

The installation scripts are all written in Bash and Python3. 
As a result, the following is necessary.
* Python3
* IPython 6.2
* Git

Without these dependencies, basic config files should not be expected to work.


## Installation
[TODO: MAKE ALL FILENAMES LINKS]

### Ubuntu:

Currently has only been tested on KDE Neon.

To replicate the working environment, run the scripts as follows.
1. Git clone the repository.
1b. (Optional) Run unix/bin/root_ubuntu_install.sh to add repositories that receive more frequent updates for Vim and Git. In addition, installs software such as OpenSSH and configures ufw very minimally.
2. Run unix/bin/symlink_repo.py to create directories and symlinks in appropriate sections of the user's home directory.

### Termux:

1. Git clone the repository.
2. Run unix/bin/symlink_repo.py to create directories and symlinks in appropriate sections of the user's home directory.
3. Run unix/bin/initial_termux_install.sh to obtain necessary packages. Termux comes with almost nothing out of the box, and as a result, packages such as findutils, file, sed, gawk, and grep must be installed by the user.
4. Execute unix/bin/python_termux.sh. This will download useful python applications like IPython, youtube-dl, flake8 and requests globally. It will also add a community repository that allows GCC, Jupyter Notebooks, and other packages to be downloaded.


## TODO:
Installation scripts will be coming soon that will allow for a turnkey solution for fresh operating systems that may not have desirable defaults.

Those scripts will start in a platform and operating system dependent way; however, as time goes on, these scripts will be able to run regardless of CPU architecture or operating system.


## Roadmap:

1. Create a minimal, functional working environment for both Termux and Ubuntu.
   (Done)
2. Create a new user on an existing workstation that has all necessary packages installed. Run relevant scripts. Is the new user profile for all intents and purposes as useful as your usual daily driver? If not, then keep working.
3. Boot a new ISO, git clone the repo, run 1 script, and begin working as if it were your daily workstation.
