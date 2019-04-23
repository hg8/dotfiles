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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
    fi

export _JAVA_AWT_WM_NONREPARENTING=1
systemctl --user import-environment DISPLAY
xsetroot -cursor_name left_ptr &
setxkbmap -layout fr
xrandr --dpi 220
wal -R
$HOME/bin/screen.sh
feh --bg-scale ~/Pictures/Wallpapers/wall.png
# xinput -list | grep -i key # Find keyboard device id
setxkbmap -device 10 us
sxhkd &
compton -f 
xss-lock -- betterlockscreen -l &
xautolock -detectsleep -locker "betterlockscreen -l" -notify 10 -notifier "notify-send -u critical -t 10000 -- 'Locking screen in 10 seconds'" &
$HOME/bin/update-notification &
# exec i3
exec bspwm
