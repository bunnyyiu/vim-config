#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`

checkIfOSSupported() {
  supported_os=(Darwin)
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
  commands=(vim git node npm go java)
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

installPlugin() {
  vim +PlugUpgrade +qall
  vim +PlugClean +PlugUpdate +PlugInstall +qall
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
  brew install grip
  if ! which grip &> /dev/null; then
    echo "grip is not installed"
  fi
}

# This install clang-format
installClangFormat() {
  brew install clang-format
  if ! which clang-format &> /dev/null; then
    echo "clang-format is not installed"
  fi
}

installGoogleJavaFormat() {
  if [ ! -f ~/.vim/java/google-java-format-VERSION-all-deps.jar ]; then
    mkdir -p ~/.vim/java
    jar="https://github.com/google/google-java-format/releases/download/google-java-format-1.6/google-java-format-1.6-all-deps.jar"
    wget $jar -O ~/.vim/java/google-java-format-VERSION-all-deps.jar
  fi
}

#check OS and dependences
checkIfOSSupported
checkIfDependenceInstalled

createVIMDirectory
installVIMConfig

installPlugin
installESlint
installGrip
installClangFormat
installGoogleJavaFormat

echo "Happy Hacking !"
