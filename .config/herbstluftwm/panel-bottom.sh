#! /bin/sh

source $(dirname $0)/config

monitor=${1:-0}
herbstclient pad $monitor 0 0 ${HEIGHT} 0

getName() {
    local cmd=$(pText ${WHITE} "$(uname -n)")
    echo $cmd
}

ram() {
    local cmd=$(pText ${WHITE} "$(free -m | grep Mem | awk '{print $3}')")
    echo $cmd
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
            wm="$wm%{F$FG}%{U$UD}%{+u}${i:1} %{-u}%{F-}"
        done
        echo "W$(getName)"
        echo "A${wm}"
        echo "R$(ram)"
    done
}|{
    while read -r line ; do
        case $line in 
            W*)
                sysL="${line#?}"
                ;;
            A*)
                wm="${line#?}"
                ;;
            R*)
                sysR="${line#?}"
                ;;
        esac
        printf "%s\n" "%{l}${sysL}%{c}${wm}%{r}${sysR}"
    done
} | lemonbar \
    -g x${HEIGHT} -u 3 -B ${BG} -F ${FG} -f "${FONT}" -f "${FONT_ICON}" -b|\
    sh &
wait 
