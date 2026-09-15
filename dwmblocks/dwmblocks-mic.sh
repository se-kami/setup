#!/bin/sh
# Dependencies: alsa-utils pulseMenu

Kmic() {
    STATUSL=$(amixer get Capture | tail -n2 | head -n1  | awk '{print $NF}')
    STATUSR=$(amixer get Capture | tail -n1 | awk '{print $NF}')
    VOLL=$(amixer get Capture | tail -n2 | head -n1 | awk '{print $(NF-1)}' | tr -d '[]')
    VOLR=$(amixer get Capture | tail -n1 | awk '{print $(NF-1)}' | tr -d '[]')
    if [ "$STATUSL" = "[off]" ] && [ "$STATUSR" = "[off]" ] ; then
        printf "%s\n" ""
    else
        printf ": %s %s\n" "$VOLL" "$VOLR"
    fi
}

Kmic

case $BUTTON in
    1) pulseMenu
esac

