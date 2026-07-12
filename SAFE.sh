#!/bin/bash

# Variables
LATEST_TAG_VERSION=`curl -s https://api.github.com/repos/NyarchLinux/NyarchLinux/releases/latest | grep "tag_name" | awk -F'"' '/tag_name/ {print $4}'`
RELEASE_LINK="github.com/NyarchLinux/NyarchLinux/releases/latest/download/"
CURRENT_ENV=${XDG_CURRENT_DESKTOP,,}
RED='\033[0;31m'
NC='\033[0m'
tarball_downloaded="false"

# curl https://raw.githubusercontent.com/NyarchLinux/NyarchLinux/main/Gnome/etc/skel/.config/neofetch/ascii70
echo -e "$RED\n\nWelcome to Nyarch Linux customization installer! $NC"

# Detects package manager/OS
if [[ -f /bin/pacman ]]; then
    echo "Pacman is installed."
elif [[ -f /bin/apt ]]; then
    echo "APT is installed."
elif [[ -f /bin/dnf ]]; then
    echo "DNF is installed."
else
    echo "No supported package manager found. Exiting."
    exit 1
fi

# Dectects DE
if [[ $CURRENT_ENV == *"gnome"* ]]; then
    echo "gnome is running"
    exit
elif [[ $CURRENT_ENV == *"kde"* ]]; then
    echo "kde is running"
    exit
else 
    echo "No supported desktop environment found. Exiting."
    exit 1
fi