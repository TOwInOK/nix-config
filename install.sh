#!/usr/bin/env bash

init() {
    # Vars
    CURRENT_USERNAME='towinok'

    # Colors
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    BRIGHT=$(tput bold)
    UNDERLINE=$(tput smul)
}

confirm() {
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
}

print_header() {
    echo -E "$CYAN
 _________  ________  ___       __   ___  ________   ________  ___  __
|\___   ___|\   __  \|\  \     |\  \|\  \|\   ___  \|\   __  \|\  \|\  \
\|___ \  \_\ \  \|\  \ \  \    \ \  \ \  \ \  \\ \  \ \  \|\  \ \  \/  /|_
     \ \  \ \ \  \\\  \ \  \  __\ \  \ \  \ \  \\ \  \ \  \\\  \ \   ___  \
      \ \  \ \ \  \\\  \ \  \|\__\_\  \ \  \ \  \\ \  \ \  \\\  \ \  \\ \  \
       \ \__\ \ \_______\ \____________\ \__\ \__\\ \__\ \_______\ \__\\ \__\
        \|__|  \|_______|\|____________|\|__|\|__| \|__|\|_______|\|__| \|__|



 ________  ________  _________  ________
|\   ___ \|\   __  \|\___   ___|\   ____\
\ \  \_|\ \ \  \|\  \|___ \  \_\ \  \___|_
 \ \  \ \\ \ \  \\\  \   \ \  \ \ \_____  \
  \ \  \_\\ \ \  \\\  \   \ \  \ \|____|\  \
   \ \_______\ \_______\   \ \__\  ____\_\  \
    \|_______|\|_______|    \|__| |\_________\
                                  \|_________|

                  $BLUE https://github.com/TOwInOK $RED
                  $BLUE inspired by https://github.com/Frost-Phoenix/nixos-config $RED
      ! To make sure everything runs correctly DONT run as root ! $GREEN
                        -> '"./install.sh"' $NORMAL

    "
}

get_username() {
    echo -en "Enter your$GREEN username$NORMAL : $YELLOW"
    read username
    echo -en "$NORMAL"
    echo -en "Use$YELLOW "$username"$NORMAL as ${GREEN}username${NORMAL} ? "
    confirm
}

set_username() {
    sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./flake.nix
    sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./modules/home/audacious.nix
}

get_host() {
    echo -en "Choose a ${GREEN}host${NORMAL} - [${YELLOW}D${NORMAL}]esktop or [${YELLOW}V${NORMAL}]irtual machine: "
    read -n 1 -r
    echo

    if [[ $REPLY =~ ^[Dd]$ ]]; then
        HOST='desktop'
    elif [[ $REPLY =~ ^[Vv]$ ]]; then
        HOST='vm'
    else
        echo "Invalid choice. Please select 'D' for desktop, 'L' for laptop or 'V' for virtual machine."
        exit 1
    fi

    echo -en "$NORMAL"
    echo -en "Use the$YELLOW "$HOST"$NORMAL ${GREEN}host${NORMAL} ? "
    confirm
}

aseprite() {
    # whether to install aseprite or not
    echo -en "Disable ${GREEN}Aseprite${NORMAL} (faster install) ? [${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return
    fi
    sed -i '3s/  /  # /' modules/home/aseprite/aseprite.nix
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"

    run_disko
    generate_hw_config

    echo -en "Do you want to install the system on disk now? "
    confirm

    echo -e "\n${BLUE}Installing NixOS...${NORMAL}"
    sudo nixos-install --flake .#${HOST}

    echo -e "\n${GREEN}Installation complete. You can now reboot.${NORMAL}"

    echo -en "\n${YELLOW}reboot ? [${GREEN}y${NORMAL}/${RED}n${NORMAL}]${NORMAL}"
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        sudo reboot now
    fi
}

run_disko() {
    echo -e "\n${BLUE}Running disko to partition and mount disks...${NORMAL}"
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount ./disko.nix
}

generate_hw_config() {
    echo -e "\n${BLUE}Generating hardware-configuration.nix...${NORMAL}"
    sudo nixos-generate-config --root /mnt
    echo "configuration has been generated"
    cp /mnt/etc/nixos/hardware-configuration.nix hosts/${HOST}/hardware-configuration.nix
    echo "configuration has been copied"
}

main() {
    init

    print_header

    get_username
    set_username
    get_host

    aseprite
    install
}

main && exit 0
