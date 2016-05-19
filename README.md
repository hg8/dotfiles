My dotfiles, save me a few seconds when reinstalling my system. Also allow me to synchronize my configuration between multiple workstations. 

##Installation:

    git clone https://github.com/hg8/rc.git
    #ZSH symlinks
    ln -s ~/rc/.zshrc ~/
    #Git symlinks
    ln -s ~/rc/.gitconfig ~/
    #Vim symlinks
    ln -s ~/rc/.vim/ ~/
    ln -s ~/rc/.vimrc ~/
    
    #Install all vim bundled plugins:
    :PluginInstall
    #Update plugins :
    :PluginUpdate

##Screenshot:

![](http://i.imgur.com/qbQvpMn.jpg)
