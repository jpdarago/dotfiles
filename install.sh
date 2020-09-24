#~/bin/bash
set -euo
set -x

# Install Z4H
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v2/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v2/install)"
fi

# Install VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -fs "$(realpath .tmux.conf)" "$HOME/.tmux.conf"
ln -fs "$(realpath .vimrc)" "$HOME/.vimrc"
ln -fs "$(realpath .zshrc)" "$HOME/.zshrc"

vim +PlugInstall
