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
hsetroot -contrast 1.04 -fill images/cyberpunk-gas-masks-girl-green-eyes-sci-fi-science-fiction-f.jpg
compton &
# redshift &

### BSPWM
#exec bspwm-launch

### Herbstluftwm
#exec herbstluftwm --locked

### i3
exec i3
