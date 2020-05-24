#!/bin/bash
# Maintainer: Faris Chugthai

complete -f -F _fzf_path_completion termux-share

# this works beautifully
source $PREFIX/share/bash-completion/completions/apt
complete -F _apt pkg

complete -A command termux-chroot

# tergent would benefit from this

if [[ -n "$ANDROID_ROOT" ]]; then

    #   Termux   command   with    odd    default    of    view    not    send
    alias termux-share="termux-share -a send"

    # But let's make it easier to use
    alias share="termux-share -a send"

    # termux-open gets an option for a default file handler! Dropbox integration
    alias termux-open="termux-open --send"

    # I still want to type less
    alias opn="termux-open --send"

    complete -f -F _fzf_path_completion termux-share share termux-open opn termux-share share

    # Copy and paste for when I don't feel like firing up tmux
    alias copy="termux-clipboard-get"
    # Paste is a coreutil though
    alias pste="termux-clipboard-set"

fi

# points to nvim
# complete -F _nvim -f -d -F _fzf_path_completion termux-file-editor nvim
# points to yt
# complete -F _youtube-dl termux-url-opener

# termux-api                   termux-job-scheduler         termux-speech-to-text
# termux-apt-repo              termux-keystore              termux-storage-get
# termux-audio-info            termux-location              termux-style@
# termux-battery-status        termux-media-player          termux-telephony-call
# termux-brightness            termux-media-scan            termux-telephony-cellinfo
# termux-call-log              termux-microphone-record     termux-telephony-deviceinfo
# termux-callback              termux-notification          termux-toast
# termux-camera-info           termux-notification-list     termux-torch
# termux-camera-photo          termux-notification-remove   termux-tts-engines
# termux-change-repo           termux-open                  termux-tts-speak
# termux-chroot                termux-open-url              termux-url-opener
# termux-clipboard-get         termux-reload-settings       termux-usb
# termux-clipboard-set         termux-sensor                termux-vibrate
# termux-contact-list          termux-setup-storage         termux-volume
# termux-dialog                termux-setupclang-gfort-7@   termux-wake-lock
# termux-download              termux-setupclang-gfort-8@   termux-wake-unlock
# termux-file-editor           termux-setupgcc-7@           termux-wallpaper
# termux-fingerprint           termux-setupgcc-8@           termux-wifi-connectioninfo
# termux-fix-shebang           termux-share                 termux-wifi-enable
# termux-info                  termux-sms-inbox             termux-wifi-scaninfo
# termux-infrared-frequencies  termux-sms-list
# termux-infrared-transmit     termux-sms-send
