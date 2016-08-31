#!/usr/bin/env bash

set -e

# Source: https://gist.github.com/davejamesmiller/1965569
ask() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi
    read -p "$1 [$prompt] " REPLY </dev/tty
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

dir=`pwd`

if ask "Install symlink for .zshrc?" Y; then
  ln -sf ${dir}/.zshrc ${HOME}/.zshrc
  ln -sf ${dir}/.aliases.sh ${HOME}/.aliases.sh
fi

if ask "Install symlink for .Xresources?" Y; then
  ln -sf ${dir}/.Xresources ${HOME}/.Xresources
fi

if ask "Install symlink for .compton.conf?" Y; then
  ln -sf ${dir}/.compton.conf ${HOME}/.compton.conf
fi

if ask "Install symlink for .vimrc?" Y; then
  ln -sf ${dir}/.vimrc ${HOME}/.vimrc
fi

if ask "Install symlink for git?" Y; then
  ln -sf ${dir}/.gitconfig ${HOME}/.gitconfig
fi

if ask "Install symlink for .xinitrc?" Y; then
  ln -sf ${dir}/.xinitrc ${HOME}/.xinitrc
fi

if ask "Install symlink for bin?" Y; then
  ln -sfn ${dir}/bin ${HOME}/bin
fi

if ask "Install symlink for i3?" Y; then
  ln -sfn ${dir}/.config/i3 ${HOME}/.config/i3
fi

if ask "Install symlink for .i3blocks.conf?" Y; then
  ln -sf ${dir}/.config/i3blocks ${HOME}/.config/i3blocks
fi

if ask "Install symlink for dunst?" Y; then
  ln -sfn ${dir}/.config/dunst ${HOME}/.config/dunst
fi

if ask "Install symlink for gtk-2.0?" Y; then
  ln -sfn ${dir}/.config/gtk-2.0 ${HOME}/.config/gtk-2.0
  ln -sfn ${dir}/.gtkrc-2.0 ${HOME}/.gtkrc-2.0
fi

if ask "Install symlink for gtk-3.0?" Y; then
  ln -sfn ${dir}/.config/gtk-3.0 ${HOME}/.config/gtk-3.0
fi

if ask "Install symlink for .config/termite?" Y; then
  ln -sfn ${dir}/.config/termite ${HOME}/.config/termite
fi

