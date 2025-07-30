#!/bin/bash

VPN_NAME="wg0"
SOUND="/usr/share/sounds/freedesktop/stereo/bell.oga"

play_sound() {
    paplay "$SOUND" &
}

if ip link show "$VPN_NAME" &>/dev/null; then
    # VPN включен → отключаем
    sudo /usr/bin/wg-quick down "$VPN_NAME"
    notify-send -i network-vpn "VPN" "WireGuard отключён"
    play_sound
else
    # VPN выключен → включаем
    sudo /usr/bin/resolvconf -u
    sudo /usr/bin/wg-quick up "$VPN_NAME"
    notify-send -i network-vpn "VPN" "WireGuard подключён"
    play_sound
fi