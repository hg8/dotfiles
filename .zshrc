export ZSH="/Users/hugo/.oh-my-zsh"

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  golang        # Go section
  # kubecontext
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

SPACESHIP_CHAR_SYMBOL="$ " 
SPACESHIP_PROMPT_BOLD=false

plugins=(git sudo virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions)

source $HOME/.variables.sh
source $HOME/.fzf.sh
source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hugo/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hugo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hugo/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hugo/google-cloud-sdk/completion.zsh.inc'; fi
