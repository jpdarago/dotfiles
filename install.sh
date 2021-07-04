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

# Install VimPlug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install NodeJS
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
VERSION=node_16.x
DISTRO="$(lsb_release -s -c)"
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt install -y nodejs

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
