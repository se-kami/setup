#!/bin/sh
# Date is formatted like like this: "[Mon yyyy-mm-dd hh:mm]"

block_date() {
    printf "%s\n" "$(date "+%a %y/%m/%d %H:%M")"
}

block_date

case $BUTTON in
    1) notify-send 'date' ;;
    3) notify-send "$(cal)"
esac
