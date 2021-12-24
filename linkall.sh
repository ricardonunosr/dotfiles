#!/bin/bash

cwd=$(pwd)

#zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc

#git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig

#nvim
ln -sf "$cwd/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$cwd/nvim/lua" ~/.config/nvim/lua
