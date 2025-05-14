#!/bin/bash

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

# update packages managers
update_pkgs_manager(){
  echo -e "\n${BLUE}==> Update package managers${GRAY}"
  echo "$PASS_INPUT" | sudo -S pacman -Syu --noconfirm
  echo "$PASS_INPUT" | sudo -S yay -Syu --noconfirm
  echo "$PASS_INPUT" | sudo -S snap refresh
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