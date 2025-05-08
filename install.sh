
# install yay
sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
sudo chown -R <user>:<user> /opt/yay-git
cd /opt/yay-git && makepkg -si --noconfirm yay-git

# install snap
sudo git clone https://aur.archlinux.org/snapd.git /opt/snapd
sudo chown -R <user>:<user> /opt/snapd
cd /opt/snapd && makepkg -si --noconfirm snapd
sudo systemctl enable --now snapd.service

# update packages managers
sudo pacman -Syu && sudo yay -Syu && sudo snap refresh

# install  dependencies
sudo pacman -S --noconfirm hyprland kitty wofi waybar swaybg greetd gtkgreet git ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nautilus hyprpaper zsh neovim yt-dlp gamescope gamemode mangohud

sudo yay -S --noconfirm hyprshot hyprlock swaync brave-bin steam telegram-desktop-bin protonup-qt

sudo snap install spotify


# config gpg keys

gpg --full-generate-key
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import


# configurations

## apps config

### hyprland
cp -r ~/dofiles/hypr ~/.config/

### kitty
cp -r ~/dofiles/kitty ~/.config/

### spotify
cp ./configs/spotify.desktop ~/.local/share/applications/spotify.desktop
sudo xdg-mime default spotify.desktop x-scheme-handler/spotify

### zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh
cp ./dotfiles/.zshrc ~/.zshrc

### neovim
mkdir -p ~/.configs/nvim
touch ~/.configs/nvim/init.vm

### git
cp ~/dotfiles/.gitignore_global
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

###

# install drivers

## graphic drivers
sudo pacman -S nvidia nvidia-utils nvidia-settings
sudo mkinitcpio -P

## motherboard drivers
sudo pacman -S linux linux-firmware amd-ucode
sudo pacman -S bluez bluez-utils
sudo systemctl enable --now bluetooth

# config greeter
sudo mkdir -p /etc/systemd/system/getty@tt1.service.d
cp ./configs/override.conf /etc/systemd/system/getty@tt1.service.d/override.conf
