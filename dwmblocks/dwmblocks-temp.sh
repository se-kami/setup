#!/bin/sh

Ktemp() {
    printf "%s\n" "$(sensors | grep Core\ 1 | awk '{print $3}')"
   }

Ktemp

# case $BUTTON in
#     1) notify-send "temp"
# esac
