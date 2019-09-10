#!/bin/bash

# Move .vimrc to home folder
sudo mv .vimrc ~

# Setup Vundle and Plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # Install YouCompleteMe
    sudo apt install build-essential cmake python3-dev
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py
vim +PluginInstall +qall

# Patch font for powerline
sudo apt-get install -y fonts-powerline 

# Define global variables
echo "Input your Github username:"
read username
echo "Input your Github email:"
read useremail
git config --global user.name $username
git config --global user.email $useremail
git config --global core.excludesfile ~/.gitignore

# Define global aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.st status
