#!/bin/sh

switch() {
    currentKeyboard=$(xkb-switch)
    case $currentKeyboard in
        us) setxkbmap hr ;;
        hr) setxkbmap us ;;
    esac
}


keyboard_module() {
    # displays current keyboard
    printf "%s %s\n" "$(ibus engine)" "$(xkblayout-state print "+%s")"
}


layoutHAN="ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ\nㅁㄴㅇㄹㅎㅗㅓㅏㅣ\nㅋㅌㅊㅍㅠㅜㅡ"
layoutRUS="\n\nЁ\nЙ Ц У К Е Н Г Ш Щ З Х Ъ\nФ Ы В А П Р О Л Д Ж Э\nЯ Ч С М И Т Ь Б Ю"

case $BUTTON in
    1) notify-send -- "$(echo $layoutHAN $layoutRUS)" ;;
    3) notify-send "Getting news" ; newsboat -x reload ; newsboat -x print-unread | xargs -I {} notify-send 🗞️ {} ;;
    5) switch && pkill -RTMIN+17 dwmblocks;;
esac

keyboard_module
