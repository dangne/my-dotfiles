#!/bin/bash

echo "### Define global variables"
echo "### Input your Github username:"
read username
echo "### Input your Github email:"
read useremail
git config --global user.name $username
git config --global user.email $useremail
git config --global core.excludesfile ~/.gitignore
git config --global core.editor vim

echo "### Define global aliases"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.st status

echo "### Add SSH key to Github"
sensible-browser https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

echo "### Add GPG key to Github"
sensible-browser https://help.github.com/en/github/authenticating-to-github/adding-a-new-gpg-key-to-your-github-account
