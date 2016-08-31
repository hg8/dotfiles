# Path to your oh-my-zsh installation.
export ZSH=/home/hugo/.oh-my-zsh

ZSH_THEME="bureau"
plugins=(git sudo battery autojump virtualenvwrapper)

export WORKON_HOME=~/Envs
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/dsa_id"

source $ZSH/oh-my-zsh.sh
source ~/.aliases.sh
source /etc/profile.d/autojump.sh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
