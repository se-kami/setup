#!/usr/bin/sh

cpu_temp() {
    base_temp_dir='/sys/class/thermal/'

    for f in $base_temp_dir/thermal_zone* ; do
        new_temp=$(cat $f/temp)
        new_temp=$(echo $(echo $new_temp / 1000) | bc -l | cut -d. -f1)
        temp=$(echo ${temp} ${new_temp}C)
    done

    echo $temp
}

cpu_freq() {
    freq="$(lscpu | grep CPU\ MHz | awk '{print $3}' | cut -d"." -f1)"
    printf "CPU: %sMHz\n" "$(lscpu | grep CPU\ MHz | awk '{print $3}' | cut -d'.' -f1)"
}

cpu_freq

case $BUTTON in
    1) notify-send "cpu"
esac
