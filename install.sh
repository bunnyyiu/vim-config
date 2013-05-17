#!/usr/bin/env sh

currPath="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`
backup_opt="--backup"
if [[ $os == "Darwin" ]]; then
  #no --backup option in Mac
  backup_opt=""
fi
ln -sf $currPath/.vimrc $HOME $backup_opt
ln -sf $currPath/.vim $HOME $backup_opt
git submodule update --init --recursive
git submodule foreach git checkout master
echo "run BundleUpdate in vim to update bundled modules"
