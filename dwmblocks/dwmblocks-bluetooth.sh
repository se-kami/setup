#!/bin/sh
# Dependencies: bluetoothctl
# returns bluetooth status

bt_on() {
    # yes or no
    status="$(bluetoothctl show | grep Powered | awk '{print $NF}')"
    echo $status
}

bt_connected() {
    # yes or no
    if [ "$(bluetoothctl info)" = "Missing device address argument" ]; then
        echo "no"
    else
        echo "yes"
    fi
    }

bt_device() {
    bluetoothctl info | grep Name: | cut -d: -f2 | sed 's/\s*//'
}

bt_toggle_connect() {
    mac_ad="00:18:09:65:D2:E3"
    if [ "$(bt_on)" = "no" ]; then
        notify-send "Bluetooth - power off"
    else
        if [ "$(bt_connected)" = "yes" ]; then
            notify-send "Bluetooth - disconnecting"
            bluetoothctl disconnect "${mac_ad}"
            notify-send "Bluetooth - disconnected"
        else
            notify-send "Bluetooth - connecting"
            bluetoothctl connect "${mac_ad}" || exit
            notify-send "Bluetooth - connected"
        fi
    fi
}

bt() {
    if [ "$(bt_on)" = "no" ]; then
        echo ""
    else
        if [ "$(bt_connected)" = "yes" ]; then
            echo ""
        else
            echo ""
        fi
    fi
}

case $BUTTON in
    1) st -e bluetoothctl ;;
    2) bt_toggle_connect ;;
    3) notify-send "$(bt_device)" ;;
esac

bt
