#!/usr/bin/env bash

# Пути и темы
dir="$HOME/.config/rofi/powermenu/type-2"
theme='style-5'

# Опции и иконки
shutdown=''
reboot=''
lock='󰌾'
suspend='󰒲'
logout='󰍃'
yes=''
no=''

# Аптайм
uptime=$(uptime -p | sed -e 's/up //g')

# Rofi главное меню
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme "${dir}/${theme}.rasi"
}

# Подтверждение
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you sure?' \
		-theme "${dir}/${theme}.rasi"
}

# Выбор опции
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Выполнение команды
run_cmd() {
	confirm=$(echo -e "$yes\n$no" | confirm_cmd)
	if [[ "$confirm" != "$yes" ]]; then
		exit
	fi

	case "$1" in
		--shutdown) systemctl poweroff ;;
		--reboot) systemctl reboot ;;
		--suspend)
			playerctl pause &>/dev/null
			amixer set Master mute &>/dev/null
			systemctl suspend
			;;
		--logout) killall Hyprland ;;
	esac
}

# Основной блок
chosen="$(run_rofi)"
case "$chosen" in
    $shutdown) run_cmd --shutdown ;;
    $reboot) run_cmd --reboot ;;
    $lock) hyprlock ;;
    $suspend) run_cmd --suspend ;;
    $logout) run_cmd --logout ;;
esac
