# Path to your oh-my-zsh installation.
export ZSH=/home/hugo/.oh-my-zsh

ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
  context
  dir
  virtualenv
  status
  cmd_exec_time
  git
  )
BULLETTRAIN_DIR_FG="black"
BULLETTRAIN_DIR_BG="green"
BULLETTRAIN_VIRTUALENV_BG="blue"
BULLETTRAIN_VIRTUALENV_FG="black"
BULLETTRAIN_EXEC_TIME_BG="red"
BULLETTRAIN_GIT_BG="black"
BULLETTRAIN_GIT_FG="white"

plugins=(git sudo virtualenvwrapper)

export GPGKEY=CE203A57
export GOPATH=~/go
export PATH=$PATH:~/go/bin
export WORKON_HOME=~/Envs
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/dsa_id"

source $ZSH/oh-my-zsh.sh
