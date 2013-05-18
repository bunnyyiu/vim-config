#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`
ctags_version="ctags-5.8"
backup_opt="--backup"

if [[ $os == "Darwin" ]]; then
  #no --backup option in Mac
  backup_opt=""
fi

# install ctags
if [[ $os == "SunOS" ]]; then
  if !which ctags &> /dev/null; then
    wget http://prdownloads.sourceforge.net/ctags/$ctags_version.tar.gz
    tar -xvf $ctags_version.tar.gz
    (cd $ctags_version; ./configure; make; make install)
    rm -rf $ctags_version*
    echo "ctags installed"
  fi
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

#install gotags
if which go &> /dev/null; then
  (cd .vim;
  mkdir -p gotags;
  export gotags=`pwd`;
  go get -u github.com/jstemmer/gotags)
else
  echo "go lang not existed. please install gotags by yourself."
fi

git submodule update --init --recursive
git submodule foreach git checkout master
echo "run BundleUpdate in vim to update bundled modules"

#install .vimrc & .vim
ln -sf $current_path/.vimrc $HOME $backup_opt
ln -sf $current_path/.vim $HOME $backup_opt
echo "created symbolic link to $HOME/.vimrc & $HOME/.vim"
