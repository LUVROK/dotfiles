#!/bin/sh
rofi_command="rofi -theme $HOME/.config/rofi/config/power-menu.rasi"

uptime=$(uptime | sed -e 's/up.*//g')

if [[ "$DIR" == "powermenus" ]]; then
	shutdown=""
	reboot=""
	lock=""
	suspend=""
	logout=""
	ddir="$HOME/.config/rofi/config"
else
	layout=$(cat $HOME/.config/rofi/config/power-menu.rasi | grep BUTTON | cut -d'=' -f2 | tr -d '[:blank:],*/')
	if [[ "$layout" == "TRUE" ]]; then
		shutdown="⏻"
		reboot=""
		lock=""
		suspend="󰤄"
		logout="󰗽"
	else
		shutdown="⏻"
		reboot=""
		lock=""
		suspend="󰤄"
		logout="󰗽"
	fi
	ddir="$HOME/.config/rofi/config"
fi

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
case $chosen in
    "$lock")
        xset dpms force off
        ;;
	"$suspend")
		pkill -x mpv
		systemctl suspend
        ;;
    "$logout")
		pkill dwm
        ;;
    "$reboot")
		systemctl reboot
        ;;
	"$shutdown")
		systemctl poweroff
        ;;
esac