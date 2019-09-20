#!/bin/bash

echo "### Define global variables"
echo "### Input your Github username:"
read username
echo "### Input your Github email:"
read useremail
git config --global user.name $username
git config --global user.email $useremail
git config --global core.excludesfile ~/.gitignore

echo "### Define global aliases"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.st status
