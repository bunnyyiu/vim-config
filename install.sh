#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd)"
os=`uname`
ctags_version="ctags-5.8"

installVimDirectory() {
  mkdir -p ~/.vim
}

installVundle() {
  if [ -d ~/.vim/bundle/vundle ]; then
    (cd ~/.vim/bundle/vundle; git pull)
  else
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  fi
}

installCtags() {
  #skip if installed
  if which ctags &> /dev/null; then
    ctags_installed=true
    return
  fi

  if [ "$os" == "SunOS" ]; then
    wget http://prdownloads.sourceforge.net/ctags/$ctags_version.tar.gz
    tar -xvf $ctags_version.tar.gz
    (cd $ctags_version; ./configure; make; make install)
    rm -rf $ctags_version*
  elif [ "$os" == "Linux" ]; then
    if which apt-get &> /dev/null; then
      sudo apt-get install exuberant-ctags
    elif which yum &> /dev/null; then
      sudo yum install exuberant-ctags
      echo "Please install exuberant-ctags by yourself."
    fi
  elif [ "$os" == "Darwin" ]; then
    if which brew &> /dev/null; then
      brew install ctags-exuberant
    elif which port&> /dev/null; then
      port install ctags
    fi
  fi

  #check again to ensure the installation is successed
  if which ctags &> /dev/null; then
    ctags_installed=true
  fi
}

#install gotags
installGoTags() {
  export PATH=~/.vim/gotags/bin:$PATH
  if which gotags &> /dev/null; then
    return
  fi
  if ! which go &> /dev/null; then
    echo "go lang not installed. please install gotags by yourself."
    return
  fi

  installCtags
  if [ $ctags_installed != true ]; then
    echo "Please install exuberant-ctags by yourself."
    return
  fi

  (cd ~/.vim;
  mkdir -p gotags;
  export GOPATH=~/.vim/gotags;
  go get -u github.com/jstemmer/gotags)
  if which gotags &> /dev/null; then
    echo "Installed gotags"
  else
    echo "Error in installing gotags"
  fi
}

#install JShint
installJShint() {
  if which jshint &> /dev/null; then
    return
  fi
  if ! which node &> /dev/null; then
    echo "node.js is not installed, please install JSHint by yourself."
    return
  fi
  if ! which npm &> /dev/null; then
    echo "npm is not installed, please install JSHint by yourself."
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

installConfigs() {
  cp $current_path/.vimrc $HOME
  echo "Installed .vimrc to $HOME/.vimrc"

  if which jshint &> /dev/null; then
    cp $current_path/.jshintrc $HOME
    echo "Installed .jshintrc to $HOME/.jshintrc"
  fi
}

installVimDirectory
installVundle
installGoTags
installJShint
installConfigs
echo "Run BundleUpdate in vim to update bundled modules"
