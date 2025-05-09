#!/bin/bash

GRAY="\033[38;5;250m"
GREEN="\033[38;5;82m"
BLUE="\033[36m"
RESET="\033[97m"
SCRIPT_PATH="$(pwd)"
USER_INPUT=_
EMAIL_INPUT=_
PASS_INPUT=_

# install yay
install_yay(){
  echo -e "\n${BLUE}==> Installing arch AUR package manager (yay)${GRAY}"
  echo "$PASS_INPUT" | sudo -S git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
  echo "$PASS_INPUT" | sudo -S chown -R $USER_INPUT:$USER_INPUT /opt/yay-git
  cd /opt/yay-git
  makepkg -si --noconfirm yay-git
}

# install snap
install_snap(){
  echo -e "\n${BLUE}==> Installing snap package manager${GRAY}"
  echo "$PASS_INPUT" | sudo -S git clone https://aur.archlinux.org/snapd.git /opt/snapd
  echo "$PASS_INPUT" | sudo -S chown -R $USER_INPUT:$USER_INPUT /opt/snapd
  cd /opt/snapd
  makepkg -si --noconfirm snapd
  echo "$PASS_INPUT" | sudo -S systemctl enable --now snapd.service
}

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

install_pkg() {
  local package=$2
  local pkg_manager=$1
  local package_founded="_"
  echo -e "${GREEN}==> [${pkg_manager}]${RESET} installing package ${GREEN}${package}${GRAY}"
  
  if [[ "$pkg_manager" == "yay" || "$pkg_manager" == "pacman"  ]]; then
    package_founded=$(${pkg_manager} -Q $package 2>&1 | grep -o "error")
  fi

  if [[ "$package_founded" == "error" ]]; then
    if [[ "$pkg_manager" == "yay" ]]; then
      yay -S --noconfirm $package
    elif [[ "$pkg_manager" == "pacman" ]]; then
      echo "$PASS_INPUT" | sudo -S pacman -S --noconfirm $package
    else
      echo "$PASS_INPUT" | sudo -S snap install $package
    fi
    echo -e "${BLUE}  -> ${RESET}package installed"
  else
    echo -e "${BLUE}  -> ${RESET}already installed"
    return 1
  fi
}

# config gpg keys
set_gpg_key(){
  echo -e "\n${BLUE}==> Set GPG Key${GRAY}"
#  gpg --full-generate-key 
  gpg --batch --gen-key <<EOF
  %echo Generate GPG key
  Key-Type: RSA
  Key-Length: 4096
  Subkey-Type: RSA
  Subkey-Length: 4096
  Name-Real: "$USER_INPUT"
  Name-Comment: "Key for sign"
  Name-Email: "$EMAIL_INPUT"
  Expire-Date: 0
  Passphrase: "$PASS_INPUT"
  %commit
  %echo Key generated successfully
EOF

  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import
}

# update packages managers
update_pkgs_manager(){
  echo -e "\n${BLUE}==> Update package managers${GRAY}"
  echo "$PASS_INPUT" | sudo -S pacman -Syu --noconfirm
  echo "$PASS_INPUT" | sudo -S yay -Syu --noconfirm
  echo "$PASS_INPUT" | sudo -S snap refresh
}

# install  dependencies
install_all_pkgs() {
  echo -e "\n${BLUE}==> Install all dependencies${GRAY}"
  
  install_pkg pacman dunst
  install_pkg pacman grim
  install_pkg pacman htop
  install_pkg pacman hyprland
  install_pkg pacman iwd
  install_pkg pacman kitty
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
  install_pkg pacman wofi
  install_pkg pacman wpa_supplicant
  install_Pkg pacman xdg-desktop-portal-hyprland
  install_pkg pacman xdg-utils
  
  install_pkg pacman nautilus
  install_pkg pacman hyprpaper
  install_pkg yay hyprshot
  install_pkg yay hyprlock
  install_pkg yay swaync

  install_pkg pacman waybar
  install_pkg pacman ttf-font-awesome
  install_pkg pacman noto-fonts
  install_pkg pacman noto-fonts-cjk
  install_pkg pacman noto-fonts-emoji
  install_pkg pacman noto-fonts-extra
  install_pkg pacman zsh
  install_pkg pacman neovim
  install_pkg pacman yt-dlp
  install_pkg pacman gamescope
  install_pkg pacman gamemode
  install_pkg pacman mangohud

  install_pkg yay brave-bin
  install_pkg yay steam
  install_pkg yay telegram-desktop-bin
  install_pkg yay protonup-qt

  install_pkg snap spotify
  install_pkg snap discord
}

# configurations
set_configs(){
  echo -e "\n${BLUE}==> Setting some configurations${GRAY}"

  ## apps config
  mkdir -p /home/$USER_INPUT/.local/share/applications/

  ### hyprland
  cp -r ${SCRIPT_PATH}/dotfiles/hypr ~/.config/
  cp -r ${SCRIPT_PATH}/backgrounds ~/

  ### kitty
  cp -r ${SCRIPT_PATH}/dotfiles/kitty ~/.config/

  ### spotify
  cp ${SCRIPT_PATH}/configs/spotify.desktop ~/.local/share/applications/spotify.desktop
  echo "$PASS_INPUT" | sudo -S xdg-mime default spotify.desktop x-scheme-handler/spotify

  ### neovim
  mkdir -p ~/.config/nvim
  touch ~/.config/nvim/init.vm

  ### git
  cp ${SCRIPT_PATH}/dotfiles/.gitignore_global ~/.gitignore_global
  git config --global user.name "$USER_INPUT"
  git config --global user.email "$EMAIL_INPUT"
  git config --global color.ui auto
  git config --global core.editor "nvim"
  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.cm commit
  git config --global alias.last 'log -1 HEAD'
  git config --global alias.rv 'reset --soft HEAD~1'
  git config --global alias.lg 'log --oneline --graph --decorate --all'
  git config --global core.excludesfile ~/.gitignore_global

  ### zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  cp ${SCRIPT_PATH}/dotfiles/.zshrc ~/.zshrc
  chsh -s $(which zsh)
}

# config greeter
config_greeter() {
  echo "$PASS_INPUT" | sudo -S mkdir -p ${SCRIPT_PATH}/configs/override.conf /etc/systemd/system/getty@tt1.service.d/
  echo "$PASS_INPUT" | sudo -S touch /etc/systemmd/system/getty@tt1.service.d/override.conf
  echo "$PASS_INPUT" | sudo -S cat > /etc/systemmd/system/getty@tt1.service.d/override.conf <<EOF
  [Service]
  ExecStart=
  ExecStart=-/usr/bin/agetty --autologin $USER_INPUT --noclear %I $TERM
EOF
}

main() {
  sudo -v
  while true; do sudo -n true; sleep 60; done &
  KEEP_ALIVE_PID=$!
  
  read -p "> username: " USER_INPUT
  read -sp "> password: " PASS_INPUT
  echo "******"
  read -p "> email: " EMAIL_INPUT
  
  if [[ -z "$USER_INPUT" && -z "$PASS_INPUT" && -z "$EMAIL_INPUT" ]]; then
    echo "The values cant be empty"
  else
    set_gpg_key
    install_yay
    install_snap
    update_pkgs_manager
    install_drivers
    install_all_pkgs
    set_configs
    config_greeter
  fi

  kill $KEEP_ALIVE_PID
  echo -e "${RESET}"
}

main
