#!/bin/bash

# install drivers
install_drivers(){
  echo -e "\n${BLUE}==> Installing drivers${GRAY}"
  ## graphic drivers
  install_pkg pacman dkms
  install_pkg pacman libva-nvidia-driver
  install_pkg pacman nvidia-dkms
  #install_pkg pacman nvidia-open-dkms
  install_pkg pacman xorg-server
  install_pkg pacman xorg-xinit
  
  install_pkg pacman nvidia-utils
  install_pkg pacman nvidia-settings
  install_pkg pacman lib32-nvidia-utils
  install_pkg pacman egl-wayland
  echo "$PASS_INPUT" | sudo -S mkinitcpio -P

  ## motherboard drivers
  install_pkg pacman amd-ucode
  install_pkg pacman bluez
  install_pkg pacman bluez-utils
  echo "$PASS_INPUT" | sudo -S systemctl enable --now bluetooth
}

# install  dependencies
install_all_pkgs() {
  echo -e "\n${BLUE}==> Install all dependencies${GRAY}"
  
  install_pkg yay stow

  install_pkg pacman dunst
  install_pkg pacman grim
  install_pkg pacman htop
  install_pkg pacman iwd
  install_pkg pacman nano
  install_pkg pacman openssh
  install_pkg pacman polkit-kde-agent
  install_pkg pacman qt5-wayland
  install_pkg pacman qt6-wayland
  install_pkg pacman slurp
  install_pkg pacman smartmontools
  install_pkg pacman polkit-kde-agent
  install_pkg pacman wget
  install_pkg pacman wireless_tools
  install_pkg pacman wpa_supplicant
  install_Pkg pacman xdg-desktop-portal-hyprland
  install_pkg pacman xdg-utils
 
  #stow libraries symlinks
  install_pkg pacman starship
  install_pkg yay rofi
  install_pkg pacman kitty
  install_pkg pacman hyprland
  install_pkg yay hyprlock
  install_pkg pacman hyprpaper
  install_pkg yay hypridle
  install_pkg pacman waybar
  install_pkg pacman zsh
  install_pkg pacman neovim
  install_pkg pacman ghostty
  install_pkg yay steam
  
  install_pkg pacman nautilus
  install_pkg yay hyprshot
  install_pkg yay swaync
  install_pkg pacman ttf-font-awesome
  install_pkg pacman noto-fonts
  install_pkg pacman noto-fonts-cjk
  install_pkg pacman noto-fonts-emoji
  install_pkg pacman noto-fonts-extra
  install_pkg pacman yt-dlp
  install_pkg pacman gamescope
  install_pkg pacman gamemode
  install_pkg pacman mangohud

  install_pkg yay brave-bin
  install_pkg yay telegram-desktop-bin
  install_pkg yay protonup-qt

  install_pkg snap spotify
  install_pkg snap discord
}