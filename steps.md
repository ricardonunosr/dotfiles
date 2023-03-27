# Steps

```bash
sudo apt-get install curl -y
curl https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb --output ~/Downloads/dropbox.deb
sudo apt-get install ~/Downloads/dropbox.deb -y

sudo apt-get install git keepassxc flameshot i3 stow zsh fzf clang -y
sudo snap install scc -y

stow home

Optional:
sudo apt-get install zeal -y
sudo apt-get install kitty -y
sudo apt-get install tmux -y
sudo apt-get install ripgrep -y
sudo apt-get install fd-find -y
sudo snap install spotify -y
#Neovim
https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
```

Paste into `~/.config/gtk-3.0/settings.ini`
```ini
[Settings]
gtk-application-prefer-dark-theme=1
```

```bash
brew install --cask dropbox
brew install --cask keepassxc
brew install --cask rectangle
brew install --cask spotify
```
