#!/bin/sh

# Dependancies: iw

device=$(iw dev | grep Interface | awk '{print $2}')

fullKwifi() {
   CONSTATE=$(iw dev $device link | awk 'NR==1{print $1}')

   case $CONSTATE in
      'Connected')
         CONSSID=$(iw dev $device link | grep SSID | awk '{print $2}')
         CONRSSI=$(iw dev $device link | grep signal | awk '{print $2 $3}')
         printf "%s %s\n" "$CONSSID" "$CONRSSI"
         ;;
#======================================================================#
      'Not')
         printf "\uF92D %s\n" "$CONSTATE"
         ;;
      'INTERFACE_DISABLED')
         printf "\uF92D %s\n" "$CONSTATE"
         ;;
#======================================================================#
      'SCANNING')
         printf "\uF92A %s\n" "$CONSTATE"
         ;;
      'ASSOCIATING')
         printf "\uF92A %s\n" "$CONSTATE"
         ;;
      'ASSOCIATED')
         printf "\uF92A %s\n" "$CONSTATE"
         ;;
      'AUTHENTICATING')
         printf "\uF92A %s\n" "$CONSTATE"
         ;;
#======================================================================#
      '4WAY_HANDSHAKE')
         printf "\uF92B %s\n" "$CONSTATE"
         ;;
      'GROUP_HANDSHAKE')
         printf "\uF92B %s\n" "$CONSTATE"
         ;;
      'INACTIVE')
         printf "\uF92B %s\n" "$CONSTATE"
         ;;
   esac
}

iconKwifi() {
CONSTATE=$(iw dev $device link | awk 'NR==1{print $1}')
if [ $CONSTATE = "Connected" ] ; then
    status="直"
else
    status="睊"
fi
echo $status
}

iconKwifi

case $BUTTON in
    1) notify-send "$(fullKwifi)" ;;
    3) notify-send "Scanning wifi" ; notify-send "$(iwscan | tail -n +5)" ;;
esac
