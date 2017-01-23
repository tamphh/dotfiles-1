#! /bin/sh

source $(dirname $0)/config

[ -e "$PANEL_HERB" ] && rm "$PANEL_HERB"
mkfifo "$PANEL_HERB"

monitor=${1:-0}
herbstclient pad $monitor ${HEIGHT}

uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

{   
    # Left side

    getName() {
        local cmd=$(pText ${WHITE} "$(uname -n)")
        echo $cmd
    }

    while :; do
        echo "T$(getName)"
        sleep 3
    done
    left_side_pid=$!

    herbstclient --idle
    kill $left_side_pid
} > "$PANEL_HERB" | {
    # Right side

    function ram() {
        local cmd=$(pText ${WHITE} "$(free -m | grep Mem | awk '{print $3}')")
        echo $cmd
    }

    while :; do
        echo "S$(ram)"
        sleep 3
    done
    right_side_pid=$!

    herbstclient --idle
    kill $right_side_pid
} > "$PANEL_HERB" | {
    # Center

    while true ; do
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
        echo "W${wm}"
    done
    center_pid=$!

    herbstclient --idle
    kill $center_pid
} > $PANEL_HERB &

$(dirname $0)/panel_bar < "$PANEL_HERB" | lemonbar \
    -g x${HEIGHT} -u 3 -B ${BG} -F ${FG} -f "${FONT}" -f "${FONT_ICON}" | sh |\
    while read line; do eval "$line"; done &

wait 
