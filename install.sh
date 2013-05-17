#!/usr/bin/env sh

currPath="$( cd "$( dirname "$0" )" && pwd)"
ln -sf $currPath/.vimrc $HOME/.vimrc
ln -sf $currPath/.vim $HOME/.vim
echo "To update module, please run BundleUpdate"
