#!/usr/bin/sh
free -h | awk '/^Mem/ { print $3"/"$2 }' | sed 's/i//g'

case "$BUTTON" in
    1) notify-send 1 ;;
    2) notify-send 2 ;;
    3) notify-send 3 ;;
    4) notify-send 4 ;;
    5) notify-send 5 ;;
esac
