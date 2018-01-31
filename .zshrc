# Path to your oh-my-zsh installation.
export ZSH=/home/hugo/.oh-my-zsh

ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
  dir
  status
  virtualenv
  cmd_exec_time
  git
  )
BULLETTRAIN_DIR_FG="black"
BULLETTRAIN_VIRTUALENV_BG="green"
BULLETTRAIN_VIRTUALENV_FG="black"
BULLETTRAIN_EXEC_TIME_BG="red"
BULLETTRAIN_GIT_BG="black"
BULLETTRAIN_GIT_FG="white"
BULLETTRAIN_DIR_BG="blue"

plugins=(common-aliases dirhistory python pip git sudo virtualenvwrapper autojump)

export WORKON_HOME=~/Envs
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/dsa_id"
export GPG_TTY=$(tty)
setopt HIST_IGNORE_SPACE

source $ZSH/oh-my-zsh.sh
source ~/.aliases.sh
source ~/.production_commands

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

genstring() {
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 14 | tr -d '\n'; echo
}
