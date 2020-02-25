export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export BAT_THEME="base16"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=~/.virtualenvs

# "ps" process list default output
export PS_FORMAT="pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args"

# Configure fzf, command line fuzzyf finder
FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="
             --no-mouse 
             --height 50% 
             -1 
             --reverse 
             --multi 
             --inline-info" 

# Use git-ls-files inside git repo, otherwise fd
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export BAT_PAGER="less -R"

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
