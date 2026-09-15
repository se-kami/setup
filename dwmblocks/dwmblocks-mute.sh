#!/bin/sh

case $BUTTON in
    1) pamixer -t && pkill -RTMIN+16 dwmblocks;;
esac

mute=$(pamixer --get-mute)

case $mute in
    true) symbol="婢" ;;
    false) symbol="墳" ;;
esac

echo $symbol
