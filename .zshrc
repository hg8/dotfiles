if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export WORKON_HOME=~/.virtualenvs

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.cargo/bin

export ZSH="/home/hugo/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git sudo pass zsh-autosuggestions zsh-syntax-highlighting virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
source ~/.aliases.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
