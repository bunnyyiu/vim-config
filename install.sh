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
  commands=(vim git node npm go java wget)
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

installJSConfig() {
  cat << EOF > ~/jsconfig.json
{
    "compilerOptions": {
        "checkJs": true
    }
}
EOF
}

installPlugin() {
  vim +PlugUpgrade +qall
  vim +PlugClean +PlugInstall +PlugUpdate +qall
}

#check OS and dependences
checkIfOSSupported
checkIfDependenceInstalled

createVIMDirectory
installVIMConfig

installPlugin

# https://github.com/ycm-core/YouCompleteMe/blob/9e2ab00bd54cf41787079bcc22e8d67ce9b27ec2/README.md#javascript-and-typescript-semantic-completion
installJSConfig

echo "Happy Hacking !"
