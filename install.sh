#!/usr/bin/env bash

currPath="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`
backup_opt="--backup"
if [[ $os == "Darwin" ]]; then
  #no --backup option in Mac
  backup_opt=""
fi
ln -sf $currPath/.vimrc $HOME $backup_opt
ln -sf $currPath/.vim $HOME $backup_opt

# install ctags
if [[ $os == "SunOS" ]]; then
  wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
  tar -xvf ctags-5.8.tar.gz
  (cd ctags-5.8; ./configure; make; make install)
elif [[ $os == "Linux" ]]; then
  if which apt-get &> /dev/null; then
    sudo apt-get install exuberant-ctags
  elif which yum &> /dev/null; then
    sudo yum install exuberant-ctags
  else
    echo "please install exuberant-ctags by yourself."
  fi
elif [[ $os == "Darwin" ]]; then
  if which brew &> /dev/null; then
    brew install ctags-exuberant
  elif which port&> /dev/null; then
    port install ctags
  else
    echo "please install exuberant-ctags by yourself."
  fi
fi
git submodule update --init --recursive
git submodule foreach git checkout master
echo "run BundleUpdate in vim to update bundled modules"
