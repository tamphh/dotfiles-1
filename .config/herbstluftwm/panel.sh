#! /bin/sh

source $(dirname $0)/config

monitor=${1:-0}
herbstclient pad $monitor ${HEIGHT} 0 ${HEIGHT} 0

set -f 

getName() {
    local icon=$(pIconUnderline ${WHITE} ${BLUE2} ${GENTOO})
    local cmd="$(uname -n)"
    local cmdEnd=$(pTextUnderline ${WHITE} ${BLUE} " ${cmd}")
    echo " ${icon}${cmdEnd}"
}

getDay() {
    local icon=$(pIconUnderline ${RED} ${BLUE2} ${CTIME})
    local cmd=" $(date '+%A %d %b')" 
    local cmdEnd=$(pTextUnderline ${WHITE} ${BLUE} "${cmd}")
    echo "${icon}${cmdEnd}"
}

clock() {
    local icon=$(pIcon ${RED} ${CCLOCK})
    local cmd=$(date +%H:%M)
    local cmdEnd=$(pText ${WHITE} "${cmd}")
    echo "${icon} ${cmdEnd}"
}

{
    while :; do
        wm=""
        TAGS=( $(herbstclient tag_status $monitor) )
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    FG=${WHITE}
                    UD=${RED}
                    ;;
                '+') # active on other monitor
                    FG=${WHITE}
                    UD=$BG
                    ;;
                ':') 
                    FG=${WHITE}
                    UD=$BG
                    ;;
                '!') # urgent tag
                    FG=${WHITE}
                    UD=$BG
                    ;;
                *) 
                    FG=${MAGENTA}
                    UD=$BG
                    ;;
            esac
            wm="$wm%{F$FG}%{U$UD}%{+u} ${i:1} %{-u}%{F-}"
        done
        echo "W$(getName)"
        echo "A${wm}"
        echo "R$(getDay) $(clock)"
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
    -g x${HEIGHT} -u 3 -B ${BG} -F ${FG} -f "${FONT}" -f "${FONT_ICON}" &
wait 
