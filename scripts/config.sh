#!/bin/bash

# set symlink files with stow
set_stow() {
  stow hypr
  stow kitty
  stow nvim
  stow rofi
  stow starship
  stow steam
  stow tmux
  stow waybar
  stow wofi
  stow zshrc
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

  ### brave
  cp ${SCRIPT_PATH}/configs/Preferences ~/.config/BraveSoftware/Brave-Browser/Default/

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
  echo "$PASS_INPUT" | sudo -S mkdir -p /etc/systemd/system/getty@tt1.service.d/
  cat > ${SCRIPT_PATH}/configs/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER_INPUT --noclear %I $TERM
EOF
  sudo cp ${SCRIPT_PATH}/configs/override.conf /etc/systemmd/system/getty@tt1.service.d/
}