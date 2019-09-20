#!/bin/bash

google_chrome(){
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
}

packages(){
    sudo apt-get install -y vim 
    sudo apt-get install -y g++
    sudo apt-get install -y python3 
    sudo apt-get install -y python3-dev
    sudo apt-get install -y trash-cli
    sudo apt-get install -y git
    sudo apt-get install -y cmake
}

typora(){
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    sudo add-apt-repository 'deb https://typora.io/linux ./'
    sudo apt-get update
    sudo apt-get install -y typora
}

unikey(){
    sudo apt-get install -y ibus-unikey
    google-chrome https://vinasupport.com/huong-dan-cai-bo-go-tieng-viet-ibus-unikey-tren-ubuntu/
    sudo apt-get update
    ibus restart
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
    bash ./gitconfig.sh
}

vim(){
    bash ./vimconfig.sh
}

bashrc(){
    cat ./.bashrc >> ~/.bashrc
}

all(){
    google_chrome
    packages
    typora
    unikey
    theme
    git
    echo "### Applying changes"
    source ~/.bashrc
}

if [ -z "$1" ]
then
    echo "usage: autoconfig.sh [<option>]"
    echo
    echo "Available options:"
    echo "      chrome              Install Google Chrome"
    echo "      packages            Install essential packages"
    echo "      typora              Install Typora for Markdown editing"
    echo "      unikey              Install Unikey for Vietnamese :)"
    echo "      theme               Install theme"
    echo "      git                 Install Git"
	echo "		vim					Install Vim"
    echo "      bashrc              Add custom config to ~/.bashrc"
    echo "      all                 Install all of above"
else
    case $1 in 
        chrome)
            chrome;;
        packages)
            packages;;
        typora)
            typora;;
        unikey)
            unikey;;
        theme)
            theme;;
        git)
            git;;
        vim)
            vim;;
        bashrc)
            bashrc;;
        all)
            all;;
        *)
            echo "Unknown option";;
    esac
fi
