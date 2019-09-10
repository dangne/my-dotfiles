#!/bin/bash

echo "### Install Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo "### Install packages"
sudo apt-get install -y vim 
sudo apt-get install -y g++
sudo apt-get install -y python3 
sudo apt-get install -y python3-dev
sudo apt-get install -y trash-cli
sudo apt-get install -y git
sudo apt-get install -y ibus-unikey
sudo apt-get install -y cmake

echo "### Setup unikey"
google-chrome https://vinasupport.com/huong-dan-cai-bo-go-tieng-viet-ibus-unikey-tren-ubuntu/
sudo apt-get update
ibus restart

echo "### Setup theme"
google-chrome https://www.gnome-look.org/p/1166289/
google-chrome https://www.gnome-look.org/p/1253385/
google-chrome http://ubuntuhandbook.org/index.php/2017/05/enable-shell-theme-in-gnome-tweak-tool-in-ubuntu/
sudo apt-get install -y papirus-icon-theme
sudo apt-get install -y gnome-tweak-tool
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
echo "### Download theme Sweet-Dark to Downloads to proceed..."
read waiting
tar -xf Sweet-Dark.tar.xz -C ~/.themes/
firefox https://extensions.gnome.org
echo "### Click the link text “click here to install browser extension” and follow the pop-ups to install the browser extension"
sudo apt install chrome-gnome-shell
firefox https://extensions.gnome.org/extension/19/user-themes/
gsettings set org.gnome.desktop.interface gtk-theme Sweet-Dark
gsettings set org.gnome.desktop.wm.preferences theme Sweet-Dark

echo "### Config git"
source ./gitconfig.sh

echo "### Apply changes"
source ~/.bashrc
