#!/usr/bin/env sh

currPath="$( cd "$( dirname "$0" )" && pwd)"
ln -sf $currPath/.vimrc $HOME/.vimrc
