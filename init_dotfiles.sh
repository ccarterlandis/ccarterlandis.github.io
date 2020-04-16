#!/bin/bash

function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

git clone --bare https://github.com/ccarterlandis/dotfiles.git $HOME/.dotfiles

mkdir -p $HOME/.config-backup

config checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout

config config status.showUntrackedFiles no

fisher