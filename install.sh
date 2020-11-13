#!/bin/bash
set -euo pipefail
set -x

# Install dependencies
sudo apt update
sudo apt install git curl wget build-essential python3 lua5.3 snapd tmux fuse libfuse2 python3-pip ripgrep

# Install NeoVim
if command -v vim &> /dev/null; then
    sudo apt-get remove --auto-remove vim￼vim-runtime vim-tiny
fi
curl -fLo ~/bin/nvim --create-dirs \
	https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
chmod u+x ~/bin/nvim

# Install VimPlug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install NodeJS
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
VERSION=node_15.x
DISTRO="$(lsb_release -s -c)"
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt install -y nodejs

# Install some NodeJS
sudo npm install -g prettier typescript

# Install latest ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install)"

# Snap and shfmt
sudo snap install core shfmt

# Set up NeoVim
sudo pip3 install neovim

# Set up files
ln -fs "$(realpath .tmux.conf)" "$HOME/.tmux.conf"
ln -fs "$(realpath .vimrc)" "$HOME/.vimrc"
ln -fs "$(realpath .zshrc)" "$HOME/.zshrc"
mkdir -p ~/.config/nvim && ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install NeoVim plugins
nvim +PlugInstall
