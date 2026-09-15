#!/usr/bin/sh

case "$BUTTON" in
    3) notify-send 3 ;;
    5) notify-send 5 ;;
esac

# option 1
# with log file
# log_file=${XDG_CACHE_HOME}/net-traffic.log
# prev_data="$(cat $log_file)"
# rx_prev=${prev_data%% *}
# tx_prev=${prev_data##* }
# rx_curr="$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd '+' | bc -l)"
# tx_curr="$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd '+' | bc -l)"
# echo $((($rx_curr - $rx_prev) / 1024))
# echo $((($tx_curr - $tx_prev) / 1024))
# echo $rx_curr $tx_curr > $log_file
##

# option 2
# sleep 10s
rx_prev="$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd '+' | bc -l)"
tx_prev="$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd '+' | bc -l)"
sleep 10
rx_curr="$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd '+' | bc -l)"
tx_curr="$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd '+' | bc -l)"
echo $((($rx_curr - $rx_prev) / 10240)) KiB/s DOWN
echo $((($tx_curr - $tx_prev) / 10240)) KiB/s UP
