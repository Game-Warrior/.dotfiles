#!/usr/bin/env sh

echo "Welcome to my Post Installtion script for Ubuntu and Debian based Distros"

sleep 2

echo "Copying my Configs"
echo "Copying awesome config"
cp -r ~/dotfiles/awesome/rc.lua ~/.config/awesome/
echo "Copying Fish Configs"
cp -r ~/dotfiles/fish/ ~/.config/fish/
echo "Copying .bashrc"
cp -r ~/dotfiles/bash/.bashrc ~/
echo "Copying Alacritty Config"
cp -r ~/dotfiles/alacritty/alacritty.yml ~/.config/
echo "Copying my Doom Emacs config"
cp -r ~/dotfiles/.doom.d/ ~/
echo "Copying my Neofetch config"
cp -r ~/dotfiles/neofetch/ ~/.config/
echo "Copying my .zshrc"
cp -r ~/dotfiles/zsh/.zshrc ~/

echo "Making Wallpapers Directory"
mkdir ~/Wallpapers
echo "Adding my Wallpapers"
cp -r ~/dotfiles/gw-wallpapers ~/Wallpapers
echo "Downloading DistroTube's Wallpapers"
cd ~/Wallpapers
git clone https://gitlab.com/dwt1/wallpapers
cd

echo "Installing Doom Emacs"
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emac.d/bin/doom install

echo "Installing Space VIM"
curl -sLf https://spacevim.org/install.sh | bash
cd ~/.SpaceVim

echo "Enableing libvirtd"
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
#echo "Adding user to libvirt&kvm group"
#sudo usermod -aG libvirt $USER
#sudo usermod -aG kvm $USER

#sleep 3

#echo "Rebooting"
#sleep 3
#reboot
