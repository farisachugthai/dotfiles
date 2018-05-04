#!/bin/bash
#
# Assumes Ubuntu
# Maintainer: Faris Chugthai


# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
apt-get update

# 4. Install Spotify
$a spotify-client

