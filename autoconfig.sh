#!/bin/bash
cd ~/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -y vim 
sudo apt-get install -y g++
sudo apt-get install -y python3 
sudo apt-get install -y python3-dev
sudo apt-get install -y trash-cli
sudo apt-get install -y git
sudo apt-get install -y ibus-unikey
sudo apt-get install -y fonts-powerline
sudo apt-get install -y cmake
sudo apt-get update
ibus restart
sudo apt-get install -y gnome-tweak-tool
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install -y papirus-icon-theme
sensible-browser https://vinasupport.com/huong-dan-cai-bo-go-tieng-viet-ibus-unikey-tren-ubuntu/
sensible-browser https://www.gnome-look.org/p/1166289/
sensible-browser https://www.gnome-look.org/p/1253385/
gsettings set org.gnome.desktop.interface gtk-theme Sweet
gsettings set org.gnome.desktop.wm.preferences theme Sweet
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/dangne/my-dotfiles.git
sudo mv my-dotfiles/.bashrc my-dotfiles/.gitignore my-dotfiles/.vimrc ..
sudo rm -rf my-dotfiles
git config --global user.name "dangne"
git config --global user.email "dang.nguyen.bkit@gmail.com"
git config --global core.excludesfile ~/.gitignore
source .bashrc
