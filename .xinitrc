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

# Script for make ssh tunnel, need enable keychain
#autossh_own &

# urxvtd -q -o -f
xsetroot -cursor_name left_ptr &
wmname LG3D
# hsetroot -fill <wallpaper>
compton &

### BSPWM
exec bspwm-launch
