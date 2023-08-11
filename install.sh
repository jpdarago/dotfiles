#!/bin/bash
set -x

# Install dependencies
sudo apt update -y
sudo apt install -y \
    git curl wget build-essential python3 lua5.3 \
    tmux fuse libfuse2 python3-pip ripgrep sakura stow \
    moreutils xclip python3-pip zsh

# Ensure Tmux and Sakura are working properly.
stow tmux sakura

# Install Meslo fonts.
if fc-list | grep -q Meslo; then
  echo "Meslo installed, skipping..."
else
  wget -O /tmp/Meslo.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
  unzip /tmp/Meslo.zip -d ~/.fonts
  fc-cache -fv
fi

sudo update-alternatives --set x-terminal-emulator /usr/bin/sakura

stow zsh

if [ ! -e ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# Install ZSH and Powerlevel10k
if [ ! -e ~/.p10k.zsh ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-autosuggestions
fi

chsh -s $(which zsh)

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh
bash /tmp/rustup.sh

# Install NeoVim
if [ ! -e /usr/local/bin/vim ]; then
  if command -v vim &> /dev/null; then
      sudo apt-get remove --auto-remove vim ￼vim-runtime vim-tiny
  fi
  curl -fLo ~/bin/nvim --create-dirs \
  	  https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod u+x ~/bin/nvim
  sudo mv ~/bin/nvim /usr/local/bin/vim
  sudo pip3 install neovim
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
fi

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs

# Install some NodeJS modules.
sudo npm install -g prettier typescript typescript-language-server

# Set up files
stow vim

# Install NeoVim plugins
vim +PlugInstall

echo "Please logout, open Sakura"
