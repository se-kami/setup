#!/usr/bin/env sh
batteries=$(find /sys/class/power_supply/ -iname 'b*')

time_left() {
    for batt in $1 ; do
        # calculate time left
        # $1 -> path to battery
        batt_name=$(echo "$batt" | sed 's/.*\///g')
        file="$1/uevent"
        power=$(cat $file | grep "POWER_SUPPLY_POWER_NOW" | cut -d'=' -f2)
        energy=$(cat $file | grep "POWER_SUPPLY_ENERGY_NOW" | cut -d'=' -f2)
        time=$(echo "60*${energy}/($power)" | bc -l | cut -d'.' -f1)
        time_left=$(echo $batt_name $time min left)
        echo $time_left
    done
}


for batt in $batteries ; do

    # get battery name
    batt_name=$(echo "$batt" | sed 's/.*\///g')
    # battery values
    batt_energy=$(cat ${batt}/energy_now)
    batt_energy_full=$(cat ${batt}/energy_full)
    batt_capacity=$(cat ${batt}/capacity)
    batt_status=$(cat ${batt}/status)

    # send notification if battery is empty
    thresh_empty=30
    if [ $batt_capacity -lt $thresh_empty ] && [ "$batt_status" != "Charging" ] ; then
        notify-send -u critical "Low battery!"
    fi

    # send notification if battery is full
    thresh_full=80
    if [ $batt_capacity -gt $thresh_full ] && [ "$batt_status" = "Charging" ] ; then
        notify-send -u normal "Battery full!"
    fi
    # change status to emoji
    case $batt_status in
        Discharging)
            if [ $batt_capacity -gt 90 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 80  ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 70 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 60 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 50 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 40 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 30 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 20 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 10 ]; then
                batt_status=""
            else
                batt_status=""
            fi ;;
        Charging)
            if [ $batt_capacity -gt 85 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 70  ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 55 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 40 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 25 ] ; then
                batt_status=""
            elif [ $batt_capacity -gt 10 ]; then
                batt_status=""
            else
                batt_status=""
            fi ;;
        "Not charging") batt_status="" ;;
        **) batt_status="❗" ;;
    esac

    # message
    # echo "$batt_energy $batt_energy_full" | awk '{a=$1; b=$2;printf "%.2f%%\n", 100*a/b}'
    echo "${batt_status} ${batt_capacity}"

done

case $BUTTON in
    1) notify-send "$(time_left "$batteries")" ;;
esac
