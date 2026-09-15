#!/bin/sh

mpc_module() {
    STATUS=$(mpc status | grep "\[.*\] *#" | awk '{print $1}')
    if [ "$STATUS" = "[playing]" ]; then
        STATUS="▶"
    elif [ "$STATUS" = "[paused]" ]; then
            STATUS="⏸"
    else STATUS="■"
    fi
    printf "%s\n" "$STATUS"
}

mpc_module

case $BUTTON in
    1) notify-send "mpc"
esac
