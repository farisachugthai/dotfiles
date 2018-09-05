# Dotfiles

A repository that hosts the dotfiles for my Ubuntu workstations and a Termux development environment.

Installation scripts have been included to assist in setup.


## Dependencies:

The installation scripts are all written in Bash and Python3. 
As a result, the following is necessary.
* Python3
* Git

Without these dependencies, the installation scripts are not guaranteed to work.


## Installation

### Ubuntu:

To replicate the working environment, run the scripts as follows.

1. Git clone the repository.

```bash
git clone https://github.com/farisachugthai/dotfiles
```

  
  - (Optional) Run [minimal_ubuntu_install.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/minimal_ubuntu_install.sh) to add repositories that receive more frequent updates for Vim and Git. 
  - In addition, this script installs software such as OpenSSH and configures ufw minimally.
  - Be aware that this script requires root permissions. From the root of the repository, it's therefore necessary to run

```bash
sudo bash "unix/bin/minimal_ubuntu_install.sh"
```

- (Optional) Run [full_ubuntu_install.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/full_ubuntu_install.sh) for more software.
- Currently adds Spotify and VS Code to apt's sources.
- Neofetch is currently added as well as it is not in the Ubuntu 16.04 repositories.
- The full install is preprended by the minimal install script, so it's not necessary to run both.


2. Run [symlink_repo.py](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/symlink_repo.py) to create directories and symlinks in appropriate sections of the user's home directory.
3. (Optional) Run [user_ubuntu.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/user_ubuntu.sh). This script does not require any special permissions and is intended to be run exclusively as a user with typical Unix permissions.

### Termux:

1. Git clone the repository.
2. Run [symlink_repo.py](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/symlink_repo.py) to create directories and symlinks in appropriate sections of the user's home directory.
3. Run [initial_termux_install.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/initial_termux_install.sh) to obtain necessary packages. 

  - Termux comes with almost nothing out of the box, and as a result, packages such as findutils, file, sed, gawk, and grep must be installed by the user. 
  - This script will also execute [python_termux.sh](https://github.com/farisachugthai/dotfiles/blob/master/unix/bin/python_termux.sh) which will download useful python applications like IPython, youtube-dl, flake8 and requests globally. 
  - It will also add a community repository that allows GCC, Jupyter Notebooks, and other packages to be downloaded.


## TODO:
Installation scripts will be coming soon that will allow for a turnkey solution for fresh operating systems that may not have desirable defaults.

Those scripts will start in a platform and operating system dependent way; however, as time goes on, these scripts will be able to run regardless of CPU architecture or operating system.


## Roadmap:

1. Create a minimal, functional working environment for both Termux and Ubuntu.
   (Done)
2. Create a new user on an existing workstation that has all necessary packages installed. Run relevant scripts. Is the new user profile as useful as your usual daily driver? If not, then keep working.
3. Boot a new ISO, git clone the repo, run 1 script, and begin working as if it were your daily workstation.
