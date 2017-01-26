#! /bin/sh

source $(dirname $0)/config

monitor=${1:-0}

set -f

music() {
    local icon=$(pIcon ${RED} ${CSOUND})
    local stat="$(mpc status | grep \# | awk '{print $1}')"
    local artist=$(mpc -f %artist% current)
    local musicname=$(mpc -f %title% current)
    local cmd=""

    if [ "${stat}" ] && [ "${stat}" = "[playing]" ] ; then
        cmd=" Playing >> ${artist:0:10} - ${musicname:0:15}"
    elif [ "${stat}" ] && [ "${stat}" = "[paused]" ] ; then
        cmd=" Paused >> ${artist:0:10} - ${musicname:0:15}"
    else
        cmd=" No Sound"
    fi

    echo "${icon}$(pText ${WHITE} "${cmd}")"
}

net() {
    local _GETIWL=$(/sbin/iwgetid -r)
    local _GETETH=$(ip a | grep "state UP" | awk '{ORS=""}{print $2}' | cut -d ':' -f 1)
    local _status=${_GETIWL:-$_GETETH}
    local _status2="${_status:-Down}"
    local icon="$(pIcon ${RED} ${CNET})"
    local cmd=$(pText ${WHITE} " ${_status2}")

    echo "${icon}${cmd}"
} 

wifi_str() {
    local _icon=$(pIcon ${RED} ${WIFI_STR})
    local _cmd=$(/sbin/iwconfig 2>/dev/null | grep "Link Quality" | cut -d "=" -f 2 | awk '{print $1}')
    echo "${_icon} ${_cmd}"
}

cpu() {
    local icon=$(pIcon ${RED} ${CCPU})
    local cmd=" $(cat /proc/loadavg | awk '{print $1}')"
    local cmd+=" $(cat /proc/loadavg | awk '{print $4}')"
    local cmd+=" $(cat /proc/cpuinfo| grep MHz | awk '{ORS=" "}{print $4}' | sed -e 's/.000//g' | cut -f 1)"

    local clr=$(pText ${WHITE} "${cmd}")
    echo "${icon}${clr}"
}

ram() {
    local icon=$(pIcon ${RED} ${CRAM})
    local cmd=$(free -m | grep Mem | awk '{print $3}')
    cmd+=" Mb"
    local clr=$(pText ${FG} "${cmd}")
    echo "${icon} ${clr}"
}

{
    while :; do
        echo "W$(music)"
        echo "A$(cpu) $(ram)"
        echo "R$(wifi_str) $(net)" 
        sleep 0.4
    done
}|{
    while read -r line ; do
        cmd=( $line )
        case "${cmd[0]}" in
            W*)
                sysL="${line#?}"
                ;;
            A*)
                wm="${line#?}"
                ;;
            R*)
                sysR="${line#?}"
                ;;
            reload)
                exit
                ;;
            quit_panel)
                exit
                ;;
        esac
        printf "%s\n" "%{l}${sysL}%{c}${wm}%{r}${sysR}"
    done
}| lemonbar \
    -g x${HEIGHT} -u 3 -B ${BG} -F ${FG} -f "${FONT}" -f "${FONT_ICON}" -b &
wait 
