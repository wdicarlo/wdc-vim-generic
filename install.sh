#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: install vim generic environment
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Walter Di Carlo (WDC), 
#  ORGANIZATION: 
#       CREATED: 08/10/2012 12:32:50 AM CEST
#      REVISION: 0.1
#===============================================================================

set -o nounset                              # Treat unset variables as an error

endpath=`pwd`

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "Installing wdicarlo Vim generic configuration...\n"

# Backup existing Vim configuration
echo "Backing up current Vim config...\n"
today=`date +%Y%m%d%H%M`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv $i $i.$today; done


echo "Setting up Vim...\n"
mkdir -p $endpath/vim/bundle
ln -s $endpath/vimrc $HOME/.vimrc
ln -s $endpath/vim $HOME/.vim

echo "Installing Vundle..."
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "Installing plugins using Vundle..."
vim +BundleInstall! +BundleClean +q

echo "Done."
