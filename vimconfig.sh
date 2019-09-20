#!/bin/bash

echo "### Move .vimrc to home folder"
sudo cp .vimrc ~

echo "### Setup Vundle and Plugins"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "### Install YouCompleteMe"
sudo apt install -y build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
vim +PluginInstall +qall

echo "### Patch font for powerline"
sudo apt-get install -y fonts-powerline 
