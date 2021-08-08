#!/bin/bash

# Installation for C++ development tools
set -euo pipefail
set -x

sudo apt install clang-format cmake libtinfo-dev

if [ ! -e ~/llvm-for-ccls ]; then
  curl -fLo ~/llvm-for-ccls/llvm.tar.xz --create-dirs \
      https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
  pushd ~/llvm-for-ccls
  tar --checkpoint=100 --checkpoint-action=totals --strip-components=1 -xf llvm.tar.xz
  popd
fi

if [ ! -e ~/bin/ccls ]; then
  [ -e /tmp/ccls ] || git clone --depth=1 --recursive https://github.com/MaskRay/ccls /tmp/ccls
  pushd /tmp/ccls
  cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$(realpath ~/llvm-for-ccls/)
  cmake --build Release
  cp /tmp/ccls/Release/ccls ~/bin/ccls
  popd
fi

