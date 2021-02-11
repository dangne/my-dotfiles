#!/bin/bash

THIS_DIR=$(DIRNAME=$(dirname "$0"); cd "$DIRNAME"; pwd)
THIS_FILE=$(basename "$0")
THIS_PATH="$THIS_DIR/$THIS_FILE"
USAGE="
usage: setup.sh [options]

Available options:

demo
all           Install & configure all
bamboo        Install ibus-bamboo
conda         Install miniconda
tmux          Install tmux
typora        Install typora 
zsh           Install zsh
bash          Configure bash
git           Configure git
gnome         Configure gnome
vim           Configure vim
misc          Install miscellaneous packages
"

install_all() {
  install_bamboo
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

  sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
  sudo apt-get update
  sudo apt-get install -y ibus-bamboo
  ibus restart
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

  sudo apt install -y tmux
}

install_typora() {
  # source: https://typora.io/#linux
  echo "Installing typora... "

  wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -

  # add Typora's repository
  sudo add-apt-repository 'deb https://typora.io/linux ./'
  sudo apt-get update

  # install typora
  sudo apt-get install -y typora
}

install_zsh() {
  echo "Installing zsh..."

  sudo apt install -y zsh
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "source ${THIS_DIR}/dotfiles/.zshrc" >> ~/.zshrc
  echo "source ${THIS_DIR}/dotfiles/.bashrc" >> ~/.zshrc
}

config_bash() {
  echo "Configuring bash..."

  echo "source ${THIS_DIR}/dotfiles/.bashrc" >> ~/.bashrc
  source ~/.bashrc
}

config_git() {
  echo "Configuring git..."

  sudo apt-get install -y git
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

  cp "${THIS_DIR}/dotfiles/gruvbox-dark.xml" ~/.local/share/gedit/styles/
  dconf load /org/gnome/terminal/ < "${THIS_DIR}/dotfiles/gnome_terminal_settings_backup.txt"
  dconf load /org/gnome/gedit/ < "${THIS_DIR}/dotfiles/gnome_gedit_settings_backup.txt"
}

config_vim() {
  echo "Configuring vim..."

  sudo apt-get install -y vim 
  cp "${THIS_DIR}/dotfiles/.vimrc" ~
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
  sudo apt-get install -y fonts-powerline 
  sudo apt install -y build-essential cmake python3-dev
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py
}

install_misc() {
  echo "Installing miscellaneous packages..."

  sudo apt-get install trash-cli
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
      conda)  install_conda ;;
      tmux)   install_tmux ;;
      typora) install_typora ;;
      zsh)    install_zsh ;;
      bash)   config_bash ;;
      git)    config_git ;;
      gnome)  config_gnome ;;
      vim)    config_vim ;;
      misc)   install_misc ;;
      *)      echo "Unrecognized option: $1" ;;
    esac
    shift
  done
fi
