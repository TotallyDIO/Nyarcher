#!/bin/bash

# Variables
LATEST_TAG_VERSION=`curl -s https://api.github.com/repos/NyarchLinux/NyarchLinux/releases/latest | grep "tag_name" | awk -F'"' '/tag_name/ {print $4}'`
RELEASE_LINK="https://github.com/TotallyDIO/NyarcherAccessories/raw/refs/heads/main/"
CURRENT_ENV=${XDG_CURRENT_DESKTOP,,}
RED='\033[0;31m'
NC='\033[0m'
tarball_downloaded="false"

# curl https://raw.githubusercontent.com/NyarchLinux/NyarchLinux/main/Gnome/etc/skel/.config/neofetch/ascii70
# echo -e "$RED\n\nWelcome to Nyarch Linux customization installer! $NC"

if [[ -f /bin/pacman ]]; then
    echo "Pacman is installed."

    # Dectects DE
    if [[ $CURRENT_ENV == *"gnome"* ]]; then
        get_tarball() {
            if [ "$tarball_downloaded" = "false" ]; then
                file_path=/tmp/NyarchLinux.tar.gz
                url=${RELEASE_LINK}${LATEST_TAG_VERSION}/NyarchLinux.tar.gz
                echo "Downloading Nyarch tarball from $url"
                wget -q -O "$file_path" "$url"
                cd /tmp
                tar -xf "$file_path"

                tarball_downloaded="true"
            fi
        }
        install_extensions() {
            cd ~/.local/share/gnome-shell  # Go to Gnome extensions config folder 
            echo "Backup old extensions to extensions-backup..."
            mv -f extensions extensions-backup  # Backup old extensions 

            cp -rf /tmp/NyarchLinuxComp/Gnome/etc/skel/.local/share/gnome-shell/extensions ~/.local/share/gnome-shell
            
            # Install material you
            cd /tmp
            git clone https://github.com/FrancescoCaracciolo/material-you-colors.git
            cd material-you-colors
            make build
            make install
            npm install --prefix $HOME/.local/share/gnome-shell/extensions/material-you-colors@francescocaracciolo.github.io;
            cd $HOME/.local/share/gnome-shell/extensions/material-you-colors@francescocaracciolo.github.io
            git clone https://github.com/francescocaracciolo/adwaita-material-you
            cd adwaita-material-you
            bash local-install.sh
            # Set correct permissions 
            cd
            chmod -R 755 $HOME/.local/share/gnome-shell/extensions/*
            
            # Install material you icons 
            cp -rf /tmp/NyarchLinuxComp/Gnome/etc/skel/.config/nyarch ~/.config
            cd ~/.config/nyarch
            git clone https://github.com/vinceliuice/Tela-circle-icon-theme
        }
        get
    elif [[ $CURRENT_ENV == *"kde"* ]]; then
        echo "kde is running"
        exit
    else 
        echo "No supported desktop environment found. Exiting."
        exit 1
    fi

elif [[ -f /bin/apt ]]; then
    echo "APT is installed."

    # Detects DE
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
elif [[ -f /bin/dnf ]]; then
    echo "DNF is installed."

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
else
    echo "No supported package manager found. Exiting."
    exit 1
fi
