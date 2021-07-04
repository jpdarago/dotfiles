#!/bin/bash
set -euo pipefail
set -x

# Install dependencies
sudo apt update
sudo apt install \
    git curl wget build-essential python3 lua5.3 \
    tmux fuse libfuse2 python3-pip ripgrep sakura stow \
    nnn moreutils

# Install NeoVim
if command -v vim &> /dev/null; then
    sudo apt-get remove --auto-remove vim￼vim-runtime vim-tiny
fi
curl -fLo ~/bin/nvim --create-dirs \
	https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
chmod u+x ~/bin/nvim
sudo mv ~/bin/nvim /usr/local/bin/vim
sudo pip3 install neovim

# Install NodeJS
curl -L https://git.io/n-install | vipe | bash

# Install some NodeJS modules.
sudo npm install -g prettier typescript typescript-language-server

# Install latest ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install)"

# Change shell to ZSH.
chsh --shell /usr/local/bin/zsh

# Set up preferences
sudo update-alternatives --set x-terminal-emulator /usr/bin/sakura
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100

# Set up files
stow vim tmux zsh

# Install NeoVim plugins
vim +PlugInstall
