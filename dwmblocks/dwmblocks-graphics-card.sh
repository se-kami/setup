#!/usr/bin/sh

# check if nvidia-smi works, exit if it doesn't
nvidia-smi 1>/dev/null 2>/dev/null || (echo "nvidia error" && exit)

# get info
gpu_temp=$(nvidia-smi --format=csv,noheader --query-gpu=temperature.gpu)
gpu_free=$(nvidia-smi --format=csv,noheader --query-gpu=memory.free | sed 's/ MiB//')
gpu_used=$(nvidia-smi --format=csv,noheader --query-gpu=memory.used | sed 's/ MiB//')
gpu_total=$(nvidia-smi --format=csv,noheader --query-gpu=memory.total | sed 's/ MiB//')

gpu_used=$(echo "scale=2; "$gpu_used "/" 1024 | bc -l)
gpu_free=$(echo "scale=2; "$gpu_free "/" 1024 | bc -l)
gpu_total=$(echo "scale=2;" $gpu_total "/" 1024 | bc -l)

# emoji
if [ "${gpu_temp}" -gt 60 ] ; then
    gpu_temp_sym=""
elif [ "${gpu_temp}" -gt 50 ] ; then
    gpu_temp_sym=""
elif [ "${gpu_temp}" -gt 40 ] ; then
    gpu_temp_sym=""
elif [ "${gpu_temp}" -gt 30 ] ; then
    gpu_temp_sym=""
else
    gpu_temp_sym=""
fi

echo "${gpu_temp_sym} ${gpu_used}G/${gpu_total}G"

case "$BUTTON" in
    1) notify-send 1 ;;
    2) notify-send 2 ;;
    3) notify-send 3 ;;
    4) notify-send 4 ;;
    5) notify-send 5 ;;
esac
