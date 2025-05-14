#!/bin/bash

# set symlink files with stow
set_all_stow() {
  echo -e "\n${BLUE}==> Setting package configurations with stow${GRAY}"
	cd $SCRIPT_PATH/packages	

  set_stow hypr "~/.config/hypr/*"
  set_stow kitty
  set_stow nvim
  set_stow rofi
  set_stow starship
  set_stow steam "~/.local/share/Steam/config/config.vdf"
  set_stow tmux
  set_stow waybar
  set_stow zshrc
	set_show git
	set_stow backgrounds
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

# configurations
set_configs(){
	set_git_config
	set_zsh_config

  echo -e "\n${BLUE}==> Setting some configurations${GRAY}"

  ## apps config
  #mkdir -p /home/$USER_INPUT/.local/share/applications/

  ### spotify
  # cp ${SCRIPT_PATH}/configs/spotify.desktop ~/.local/share/applications/spotify.desktop
  # echo "$PASS_INPUT" | sudo -S xdg-mime default spotify.desktop x-scheme-handler/spotify

  ### brave
  #cp ${SCRIPT_PATH}/configs/Preferences ~/.config/BraveSoftware/Brave-Browser/Default/
}

# config greeter
config_greeter() {
  echo "$PASS_INPUT" | sudo -S mkdir -p /etc/systemd/system/getty@tt1.service.d/
  cat > ${SCRIPT_PATH}/configs/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER_INPUT --noclear %I $TERM
EOF
  sudo cp ${SCRIPT_PATH}/configs/override.conf /etc/systemmd/system/getty@tt1.service.d/
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
  chsh -s $(which zsh)
}