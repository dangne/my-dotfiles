#!/bin/bash

cd ~

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Install packages
sudo apt-get install -y vim 
sudo apt-get install -y g++
sudo apt-get install -y python3 
sudo apt-get install -y python3-dev
sudo apt-get install -y trash-cli
sudo apt-get install -y git
sudo apt-get install -y ibus-unikey
sudo apt-get install -y cmake

# Setup unikey
sensible-browser https://vinasupport.com/huong-dan-cai-bo-go-tieng-viet-ibus-unikey-tren-ubuntu/
sudo apt-get update
ibus restart

# Setup theme
sudo apt-get install -y papirus-icon-theme
sudo apt-get install -y gnome-tweak-tool
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sensible-browser https://www.gnome-look.org/p/1166289/
sensible-browser https://www.gnome-look.org/p/1253385/
gsettings set org.gnome.desktop.interface gtk-theme Sweet
gsettings set org.gnome.desktop.wm.preferences theme Sweet

# Config git
source gitconfig.sh

# Apply changes
source .bashrc
