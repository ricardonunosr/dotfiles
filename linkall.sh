#!/bin/bash

cwd=$(pwd)

#zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc

#git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig
