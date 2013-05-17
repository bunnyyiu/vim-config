#!/usr/bin/env sh

currPath="$( cd "$( dirname "$0" )" && pwd)"
ln -sf $currPath/.vimrc $HOME --backup
ln -sf $currPath/.vim $HOME --backup
git submodule update --init --recursive
git submodule foreach git checkout master
echo "run BundleUpdate in vim to update bundled modules"
