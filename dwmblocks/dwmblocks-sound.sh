#!/bin/sh
# Dependencies: alsa-utils

sound_module() {
    # 0 if there is no left speaker
    Status=$(amixer get Master | grep "Front Left" | wc -l)
    # get either right or only speaker
    STATUSR=$(amixer get Master | tail -n1 | awk '{print $NF}')
    VOLR=$(amixer get Master | tail -n1 | awk '{print $(NF-1)}' | sed 's/\([.*%]]\)//' | cut -d"[" -f2 )

    # if status is not 0(left speaker exists), then get volume
    if [ $Status != 0 ] ; then
        VOLL=$(amixer get Master | grep "Front Left" | tail -n1 | awk '{print $(NF-1)}' | sed 's/\([.*%]]\)//' | cut -d"[" -f2 )
        STATUSL=$(amixer get Master | tail -n2 | head -n1  | awk '{print $NF}')
        if [ "$STATUSL" = "[off]" ] && [ "$STATUSR" = "[off]" ] ; then
            printf "%s\n" "婢"
        else
            printf "墳 %s %s\n" "$VOLL" "$VOLR"
        fi
    else
        if [ $STATUSR = "[off]" ] ; then
            printf "%s\n" "婢"
        else
            printf "墳 %s\n" "$VOLR"
        fi
    fi

}

sound_module

case $BUTTON in
    1) notify-send "sound" ;;
    4) amixer -D pulse sset Master 5%+ ;;
    5) amixer -D pulse sset Master 5%- ;;
esac




# simpler solution
# pamixer --get-volume

# case $BLOCK_BUTTON in
# 	1) pamixer -i 10 && pkill -RTMIN+13 dwmblocks ;;
# 	3) pamixer -d 10 && pkill -RTMIN+13 dwmblocks ;;
# esac

