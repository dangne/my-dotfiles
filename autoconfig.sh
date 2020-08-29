#!/bin/bash

packages(){
    sudo apt-get update

    # Packages for my coding stuffs
    sudo apt-get install -y git
    sudo apt-get install -y vim 
    sudo apt-get install -y build-essential
    sudo apt-get install -y python3 

    # Utilities
    sudo apt-get install -y trash-cli
}

typora(){
    # Best tool for markdown editor
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    sudo add-apt-repository 'deb https://typora.io/linux ./'
    sudo apt-get update
    sudo apt-get install -y typora
}

unikey(){
    # Install the new ibus-bamboo
    sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
    sudo apt-get update
    sudo apt-get install ibus-bamboo
    ibus restart
}

tmux(){
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
}

theme(){
    google-chrome https://www.gnome-look.org/p/1166289/
    google-chrome https://www.gnome-look.org/p/1253385/
    google-chrome http://ubuntuhandbook.org/index.php/2017/05/enable-shell-theme-in-gnome-tweak-tool-in-ubuntu/
    sudo apt-get install -y gnome-tweak-tool
    sudo apt-get install -y papirus-icon-theme
    sudo add-apt-repository ppa:papirus/papirus
    sudo apt-get update
    echo "### Download theme Sweet-Dark to ~/Downloads to proceed..."
    read waiting
    mkdir ~/.themes
    cd ~
    tar -xf './Downloads/Sweet-Dark.tar.xz' -C ~/.themes/
    cd -
    firefox https://extensions.gnome.org
    echo "### Click the link text “click here to install browser extension” and follow the pop-ups to install the browser extension"
    sudo apt install -y chrome-gnome-shell
    firefox https://extensions.gnome.org/extension/19/user-themes/
    gsettings set org.gnome.desktop.interface gtk-theme Sweet-Dark
    gsettings set org.gnome.desktop.wm.preferences theme Sweet-Dark
}

git(){
    source ./gitconfig.sh
}

vim(){
    source ./vimconfig.sh
}

bashrc(){
    echo "source ~/my-dotfiles/.bashrc" >> ~/.bashrc
    source ~/.bashrc
}

ssh(){
    echo "### Generate new SSH Key"
    echo "Input your email:"
    read email
    ssh-keygen -t rsa -b 4096 -C $email
}

if [ -z "$1" ]
then
    echo "usage: autoconfig.sh [<option>]"
    echo
    echo "Available options:"
    echo "      bashrc              Add my custom config to ~/.bashrc"
    echo "      git                 Install Git"
    echo "      packages            Install essential packages"
    echo "      ssh                 Create new ssh key"
    echo "      theme               Install theme"
    echo "      tmux                Install tmux" 
    echo "      typora              Install Typora for Markdown editing"
    echo "      unikey              Install ibus-bamboo for Vietnamese input"
    echo "      vim                 Install Vim"
else
    case $1 in 
        bashrc)
            bashrc;;
        git)
            git;;
        packages)
            packages;;
        ssh)
            ssh;;
        theme)
            theme;;
        tmux)
            tmux;;
        typora)
            typora;;
        unikey)
            unikey;;
        vim)
            vim;;
        *)
            echo "Unknown option";;
    esac
fi
