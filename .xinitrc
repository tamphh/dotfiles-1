#! /bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/Xresources

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Launch dbus 
if [ -d /etc/X11/xinit/xinitrc.d ] ; then

    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# SSH tunnel
autossh_own &
#urxvtd -q -o -f
xsetroot -cursor_name left_ptr &
wmname LG3D
hsetroot -fill images/798884-kerrigan-wallpaper-1920x1080-photo.jpg
compton &

# Lower the brightness to a minimum
xbacklight -set 1

# Start wm
session=${1:-subtle}
case $session in
    i3|i3wm ) exec i3;;
    bspwm ) exec bspwm-launch;;
    herbstuf|herbstluftwm ) exec herbstluftwm --locked;;
    spectr|spectrwm ) exec spectrwm 2> /tmp/spectrwm.log;;
    subtle|subtlewm ) exec subtle 2> /tmp/subtle.log;;
    * ) exec $1;;
esac
