#!/bin/bash
set -x

# Install dependencies
sudo apt update -y
sudo apt install -y \
    git curl wget build-essential python3 lua5.3 \
    tmux fuse libfuse2 python3-pip ripgrep sakura stow \
    nnn moreutils

# Ensure Tmux and Sakura are working properly.
stow tmux sakura

# Install Meslo fonts.
if fc-list | grep -q Meslo; then
  echo "Meslo installed.."
else
  wget -O /tmp/Meslo.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
  unzip /tmp/Meslo.zip -d ~/.fonts
  fc-cache -fv
fi

if [ "$TERM" != "screen-256color" ] && [ "$TERM" != "xterm-256color"]; then
    sudo update-alternatives --set x-terminal-emulator /usr/bin/sakura
    echo "Please reopen terminal and run under tmux"
    exit 1
fi

# Install ZSH and Powerlevel10k
if [ ! -e ~/.p10k.zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
  exec zsh
  p10k configure
fi

stow zsh

# Install NeoVim
if [ ! -e /usr/local/bin/vim ]; then
  if command -v vim &> /dev/null; then
      sudo apt-get remove --auto-remove vim ￼vim-runtime vim-tiny
  fi
  curl -fLo ~/bin/nvim --create-dirs \
  	  https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
  chmod u+x ~/bin/nvim
  sudo mv ~/bin/nvim /usr/local/bin/vim
  sudo pip3 install neovim
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
fi

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_17.x | vipe | sudo -E bash -
sudo apt install -y nodejs

# Install some NodeJS modules.
npm install -g prettier typescript typescript-language-server

# Set up preferences

# Set up files
stow vim

# Install NeoVim plugins
vim +PlugInstall
