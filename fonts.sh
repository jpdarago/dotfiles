#!/bin/bash
set -euo pipefail

wget -O /tmp/Meslo.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip /tmp/Meslo.zip -d ~/.fonts
fc-cache -fv
