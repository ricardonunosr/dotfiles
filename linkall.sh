#!/bin/bash 
cwd=$(pwd)

#i3
ln -sf "$cwd/i3" ~/.config/i3/config
ln -sf "$cwd/i3status" ~/.config/i3/i3status/config

#zsh
ln -sf "$cwd/.zshrc" ~/.zshrc

#nvim
ln -sf "$cwd/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$cwd/nvim/lua" ~/.config/nvim/lua
ln -sf "$cwd/nvim/colors" ~/.config/nvim/colors
