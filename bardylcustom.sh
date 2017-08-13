#!/usr/bin/env dash
# vim: set ft=sh:
#
# Dylan's bar script
#
# Created by Dylan Araps.
#
# Depends on: xorg-xrandr, wmctrl, mpc, lemonbar, ip, xdotool

font="${BAR_FONT:-"-*-lemon-*"}"
icon="${BAR_ICON:-"-*-siji-*"}"
height="${BAR_HEIGHT:-36}"


get_mon_width() {
    # Get the monitor width.
    command -v xrandr >/dev/null 2>&1 && \
        resolution="$(xrandr --nograb --current |
                      awk -F 'primary |x' '/primary/ {print $2}')"

    printf "%s\\n" "${resolution:-1920}"
}


get_workspaces() {
    # Create a dynamic workspace switcher.
    workspaces="$(wmctrl -d | awk -v fg="${color8:-#F0F0F0}" \
                                  '$6!="0,0"{next}
                                   $2=="-"{printf "  %{F"fg"}" $NF "  %{F}"}
                                   $2=="*"{printf "  " $NF "  "}')"
    printf "%s\\n" "$workspaces"
}


get_window() {
    # Get title of focused window.
    printf "%.75s\\n" "$(xdotool getwindowfocus getwindowname)"
}


get_date() {
    # Get the date and time.
    printf "%s\\n" "$(date +"%a %d %b - %H:%M")"
}



get_battery() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}'


}



main() {
    # Main script function.

    # Info that doesn't need to grabbed more than once.
    width="$(get_mon_width)"

    # Loop and print the info.
    while :; do
        workspaces="$(get_workspaces)"
        window="$(get_window)"
        date="$(get_date)"
        volume="$(get_battery)"

        printf "%s%s%s\\n" \
               "%{l}   ${workspaces} |  ${window}" \
               "%{c}${date}" \
               "%{r}${song}  |  ${volume}     "
        sleep .1s
    done

}


main "$@"
