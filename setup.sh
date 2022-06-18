#!/bin/bash

THIS_DIR=$(DIRNAME=$(dirname "$0"); cd "$DIRNAME"; pwd)
THIS_FILE=$(basename "$0")
THIS_PATH="$THIS_DIR/$THIS_FILE"
USAGE="
usage: setup.sh [options]

Available options:

all           Install & configure all
chrome        Install Google Chrome
bamboo        Install ibus-bamboo
conda         Install miniconda
tmux          Install tmux
typora        Install typora 
zsh           Install zsh
bash          Configure bash
git           Configure git
gnome         Configure gnome
vim           Configure vim
vm            Light configuration for VM
misc          Install miscellaneous packages
"

install_all() {
  apt update
  apt upgrade
  
  install_bamboo
  install_chrome
  install_conda
  install_tmux
  install_typora
  install_zsh
  config_bash
  config_git
  config_gnome
  config_vim
  install_misc
}

install_bamboo() {
  # source: https://github.com/BambooEngine/ibus-bamboo
  echo "Installing ibus-bamboo... "

  add-apt-repository ppa:bamboo-engine/ibus-bamboo
  apt-get update
  apt-get install -y ibus-bamboo
  ibus restart
}

install_chrome() {
  # source: https://linuxhint.com/ubuntu_20-04_google_chrome_installation_guide/
  echo "Installing Google Chrome... "
  
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
}

install_conda() {
  echo "Installing Miniconda... "

  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P ~
  sh ~/Miniconda3-latest-Linux-x86_64.sh 
  rm ~/Miniconda3-latest-Linux-x86_64.sh 
}

install_tmux() {
  # source: https://github.com/tmux/tmux
  echo "Installing tmux..."

  apt install -y tmux
}

install_typora() {
  # source: https://typora.io/#linux
  echo "Installing typora... "

  wget -qO - https://typora.io/linux/public-key.asc | apt-key add -

  # add Typora's repository
  add-apt-repository 'deb https://typora.io/linux ./'
  apt-get update

  # install typora
  apt-get install -y typora
}

install_zsh() {
  echo "Installing zsh..."

  apt install -y zsh
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "source ${THIS_DIR}/dotfiles/.zshrc" >> ~/.zshrc
  echo "source ${THIS_DIR}/dotfiles/.bashrc" >> ~/.zshrc
}

config_bash() {
  echo "Configuring bash..."

  echo "source ${THIS_DIR}/dotfiles/.bashrc" >> ~/.bashrc
  echo "source ${THIS_DIR}/dotfiles/.bash_aliases" >> ~/.bash_aliases
  source ~/.bashrc
  source ~/.bash_aliases
}

config_git() {
  echo "Configuring git..."

  apt-get install -y git
  read -p "Please enter your username:" username
  read -p "Please enter your email:" email
  git config --global user.name "${username}"
  git config --global user.email "${email}"
  git config --global core.excludesFile "${THIS_DIR}/dotfiles/.gitignore"
  git config --global core.editor vim
   
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.cm commit
  git config --global alias.st status
}

config_gnome() {
  echo "Configuring gnome..."

  mkdir -p ~/.local/share/gedit/styles
  cp "${THIS_DIR}/dotfiles/gruvbox-dark.xml" ~/.local/share/gedit/styles/
  dconf load /org/gnome/gedit/ < "${THIS_DIR}/dotfiles/gnome_gedit_settings_backup.txt"
  dconf load /org/gnome/terminal/ < "${THIS_DIR}/dotfiles/gnome_terminal_settings_backup.txt"
}

config_vim() {
  echo "Configuring vim..."

  apt-get install -y vim 
  cp "${THIS_DIR}/dotfiles/.vimrc" ~
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
  apt-get install -y fonts-powerline 
  apt install -y build-essential cmake python3-dev
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py
}

config_vm() {
  config_git
  echo "Copying .vimrc_light to ~/.vimrc..."
  cp "${THIS_DIR}/dotfiles/.vimrc_light" ~/.vimrc

  echo "Adding custom .bashrc..."
  echo "" >> ~/.bashrc
  cat "${THIS_DIR}/dotfiles/.bashrc" >> ~/.bashrc
  source ~/.bashrc

  echo "Adding custom .bash_aliases..."
  echo "" >> ~/.bash_aliases
  cat "${THIS_DIR}/dotfiles/.bash_aliases" >> ~/.bash_aliases
  source ~/.bash_aliases
}

install_misc() {
  echo "Installing miscellaneous packages..."

  apt-get install trash-cli
  echo "alias rm=\"trash\"" >> ~/.bash_aliases
  source ~/.bash_aliases

  apt install xsel
}

[[ $# -eq 0 ]] && h=true || h=false
for opt in $@; do
  if [[ "$opt" == "help" ]] ; then h=true ; break ; fi
done

if [[ "$h" = true ]] ; then
  echo "$USAGE" ;
else
  while [[ $# -gt 0 ]] ; do
    case "$1" in 
      all)    install_all ;;
      bamboo) install_bamboo ;;
      chrome) install_chrome ;;
      conda)  install_conda ;;
      tmux)   install_tmux ;;
      typora) install_typora ;;
      zsh)    install_zsh ;;
      bash)   config_bash ;;
      git)    config_git ;;
      gnome)  config_gnome ;;
      vim)    config_vim ;;
      vm)     config_vm ;;
      misc)   install_misc ;;
      *)      echo "Unrecognized option: $1" ;;
    esac
    shift
  done
fi
