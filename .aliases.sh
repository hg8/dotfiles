alias archpen="ssh -D 8888 hugo@127.0.0.1 -p 2222"
alias vim="nvim"
alias ls="exa --icons"
alias lt='ls --tree'
alias t='task'
alias fp="fzf --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) | head -300'"
