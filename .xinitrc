#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps

if [ -f $sysresources ]; then







	xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then





	xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#		[ -x "$f" ] && . "$f"
#	done
#	unset f
#fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

xset +fp /home/hugo/.fonts
xset fp rehash
xrandr --dpi 220
feh --bg-scale ~/Pictures/wallpaper.jpeg

exec i3
