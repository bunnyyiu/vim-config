#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`

installVIMConfig() {
  cp $current_path/vimrc $HOME/.vimrc
  echo "Installed vimrc to $HOME/.vimrc"
}

installVIMDirectory() {
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
  pushd $HOME/.vim/bundle/YouCompleteMe
  ./install.sh --clang-completer
  popd
}

#install JSHint
installJSHint() {
  if which jshint &> /dev/null; then
    return
  fi
  if ! which node &> /dev/null; then
    echo "node.js is not installed, please install node and rerun this script."
    return
  fi
  if ! which npm &> /dev/null; then
    echo "npm is not installed, please install npm and rerun this script"
    return
  fi

  npm install jshint -g
  if which jshint &> /dev/null; then
    echo "JSHint installed"
  else
    echo "Error in installing JShint"
    return
  fi
}

installJSHintConfig() {
  if which jshint &> /dev/null; then
    cp $current_path/jshintrc $HOME/.jshintrc
    echo "Installed jshintrc to $HOME/.jshintrc"
  fi
}

installVIMConfig
installVIMDirectory
installVundle
installYouCompleteMe
installJSHint
installJSHintConfig
printf "The Installation is complete!\nHappy Coding!\n"
