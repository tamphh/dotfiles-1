#!/bin/sh

TERMITE=~/.config/termite/config
DEST=$1
_COLORS=(
    "color0"
    "color1"
    "color2"
    "color3"
    "color4"
    "color5"
    "color6"
    "color7"
    "color8"
    "color9"
    "color10"
    "color11"
    "color12"
    "background"
    "foreground"
)

function writeToDest() {
    echo "*$1: $2" >> "${DEST}"
}

function retrieve() {
    local cc=$(grep "^$1=" $TERMITE) # search color= #xxxxxx
    [[ -z $cc ]] && local cc=$(grep "^$1 =" $TERMITE) # search color = #xxxxxx

    c=$(echo $cc | grep -oE '#[a-zA-Z0-9]{6}' | cut -c 1-)
    echo "$1 - $c"
    writeToDest $1 $c
}

if [[ ! -f "${DEST}" ]]; then
    for co in "${_COLORS[@]}"; do retrieve $co; done
    exit 0
else
    echo "${DEST} exist alrealy" && exit 1
fi
