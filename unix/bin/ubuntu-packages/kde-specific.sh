#!/bin/bash 
# Assumes Ubuntu
# Maintainer: Faris Chugthai

a="apt-get install -y"

$a ark              # for just an archive extractor, shockingly good
                    # has colorschemes, vim keybindings, preview splits
$a dolphin
$a dolphin-plugins
$a kde-spectacle
$a kdeconnect               # difficult to understate how great this is
$a kio-gdrive
$a kio-mtp
$a kio-stash                # git integration in dolphin AND viewable stashes
$a kleopatra                # came a LONG way usability-wise over last 2 yrs
$a konsole konsole-kpart

