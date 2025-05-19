#!/bin/bash

packages=""

# set symlink files with stow
set_all_stow() {
  echo -e "\n${BLUE}==> Setting package configurations with stow${GRAY}"
	cd ${SCRIPT_PATH}/packages

  get_packages

  for package in $packages; do
    if [ $package == "hypr" ]; then
      set_stow $package "~/.config/hypr/*"
    elif [ $package == "steam" ]; then
      set_stow $package "~/.local/share/Steam/config/config.vdf"
    else
      set_stow $package
    fi
  done
}

adopt_all_stow() {
  echo -e "\n${BLUE}==> Adopt package configurations with stow${GRAY}"
	cd ${SCRIPT_PATH}/packages

  get_packages

  for package in $packages; do
    adopt_stow $package
  done
}

set_stow() {
	PACKAGE=$1
	PATH_CONFIG=$2
  echo -e "${BLUE}==> ${RESET}config file setting for ${GREEN}${PACKAGE}${GRAY}"
	if [[ ! -z "$PATH_CONFIG" ]]; then
		echo -e "${GRAY}  -> delete old config in ${PATH_CONFIG}${GRAY}"
		rm -rf $PATH_CONFIG
	fi
	stow -t ~ $PACKAGE
}

adopt_stow() {
	PACKAGE=$1
  echo -e "${BLUE}  -> ${RESET}config file setting for ${GREEN}${PACKAGE}${GRAY}"
	stow --adopt $PACKAGE
}

get_packages() {
  packages=$(ls -1 "${SCRIPT_PATH}/packages/" | grep -E '^.*/?$')
}

# configurations
set_configs() {
  echo -e "\n${BLUE}==> Setting some configurations${GRAY}"
  
  set_git_config
	set_zsh_config
  set_java_version
  set_docker
  config_greeter
}

# config greeter
config_greeter() {
  echo "$PASS_INPUT" | sudo -S mkdir -p /etc/systemd/system/getty@tt1.service.d
  cat > ${SCRIPT_PATH}/configs/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER_INPUT --noclear %I $TERM
EOF
  echo "$PASS_INPUT" | sudo cp ${SCRIPT_PATH}/configs/override.conf /etc/systemd/system/getty@tt1.service.d/
}

set_git_config() {
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
}

set_zsh_config() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "$(which zsh)" | sudo tee -a /etc/shells
  echo "$PASS_INPUT" | chsh -s "$(which zsh)"
}

set_java_version() {
  echo "$PASS_INPUT" | sudo archlinux-java set java-17-openjdk
}

set_docker() {
  echo "$PASS_INPUT" | sudo systemctl enable docker
  echo "$PASS_INPUT" | sudo systemctl start docker
  echo "$PASS_INPUT" | sudo usermod -aG docker $USER_INPUT
}

set_blueman() {
  echo "$PASS_INPUT" | sudo systemctl enable bluetooth.service
  echo "$PASS_INPUT" | sudo systemctl start bluetooth.service
}

set_pipewire() {
  systemctl --user daemon-reexec
  systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service
}
