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

![2016-08-31-163228_1918x1079_scrot](https://cloud.githubusercontent.com/assets/9076747/18132834/9eb1c4f0-6f98-11e6-84f2-1c237a679642.png)
