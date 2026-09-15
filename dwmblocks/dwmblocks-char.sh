#!/bin/sh

charging() {
    current=0
    current=$(cat /sys/class/power_supply/AC/online)
    if [ $current = 1 ] ; then
        echo "ﮣ"
    else
        echo "ﮤ"
    fi
}

charging

case $BUTTON in
    1) "charging"
esac

