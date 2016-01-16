My dotfiles, save me a few seconds when reinstalling my system.

##Installation:

    git clone https://github.com/hg8/rc.git

#Zsh

##Create symlinks:

    ln -s ~/rc/.zshrc ~/

#Vim

##Get submodule

    cd ~/rc/.vim
    git submodule init
    git submodule update

##Create symlinks:

    ln -s ~/rc/.vim/ ~/
    ln -s ~/rc/.vimrc ~/

##Update all bundled plugins:

    git submodule foreach git pull origin master

## Install new bundled plugin
    
    cd ~/rc/.vim
    git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
    git add .
    git commit -m "Install Fugitive.vim bundle as a submodule."



