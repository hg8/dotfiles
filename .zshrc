# Path to your oh-my-zsh installation.
export ZSH=/home/hugo/.oh-my-zsh

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # Node.js section
  golang        # Go section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  pyenv         # Pyenv section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_CHAR_SYMBOL="> " 
SPACESHIP_PROMPT_BOLD=false

plugins=(git sudo virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions)

export LC_ALL=en_US.UTF-8
export GPGKEY=CE203A57
export GOPATH=~/go
export PATH=$PATH:~/go/bin
export WORKON_HOME=~/Envs
export SSH_KEY_PATH="~/.ssh/dsa_id"

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

source $ZSH/oh-my-zsh.sh
source ~/.aliases.sh
source ~/.aliases.priv.sh

(cat ~/.cache/wal/sequences &)
todo
