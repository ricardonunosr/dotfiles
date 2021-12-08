#!/bin/bash

cwd=$(pwd)

#zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc

#git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig

#nvim
ln -sf "$cwd/nvim/init.vim" ~/.config/nvim/init.vim
