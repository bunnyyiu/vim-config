#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`

checkIfOSSupported() {
  supported_os=(SunOS Linux Darwin)
  if [[ ! ${supported_os[@]} =~ $os ]]; then
    echo "Sorry, your OS is not supported."
    echo "This script only support ${supported_os[*]}"
    exit 1
  fi
}

checkIfCommandAvailable() {
  command=$1
  if ! which $command > /dev/null; then
    echo "Sorry, command '$command' is not installed, \
please install it and rerun this script."
    exit 1
  fi
}

checkIfDependenceInstalled() {
  commands=(vim git node npm go)
  for command in "${commands[@]}"
  do
    checkIfCommandAvailable $command
  done
}

installVIMConfig() {
  cp $current_path/vimrc $HOME/.vimrc
  echo "Installed vimrc to $HOME/.vimrc"
}

createVIMDirectory() {
  mkdir -p ~/.vim
}

installVundle() {
  if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
    (cd $HOME/.vim/bundle/Vundle.vim; git pull)
  else
    git clone https://github.com/gmarik/Vundle.vim.git \
      $HOME/.vim/bundle/Vundle.vim
  fi
  vim +PluginClean +PluginInstall +qall
}

installYouCompleteMe() {
  (cd $HOME/.vim/bundle/YouCompleteMe; ./install.py --clang-completer)
}

installESlint() {
  npm install eslint -g
  if which eslint &> /dev/null; then
    echo "ESLint installed"
  else
    echo "Error in installing ESLint"
    exit 1
  fi
}

# This is for markdown preview
installGrip() {
  if which brew &> /dev/null; then
    brew install grip
  elif which pip &> /dev/null; then
    pip install grip
  fi
  if ! which grip &> /dev/null; then
    echo "grip is not installed"
  fi
}

#check OS and dependences
checkIfOSSupported
checkIfDependenceInstalled

createVIMDirectory
installVIMConfig
installVundle
installYouCompleteMe
installESlint
installGrip

echo "Happy Coding!"
