#!/bin/sh

# Получаем список устройств (одна строка = одно устройство)
devices=$(razer-cli -l | grep "^Razer")

# Если устройств нет — выход
[ -z "$devices" ] && { notify-send "Razer" "No devices found"; exit 1; }

# Выбор устройства через rofi
chosen_device=$(echo "$devices" | rofi -dmenu -p "Device")
[ -z "$chosen_device" ] && exit 0

# Обрезаем только имя до двоеточия
device_name=$(echo "$chosen_device" | cut -d: -f1)

# Выбор DPI
options="400\n800\n1600\n2400\n3200\n6400\n12000\n20000"
dpi=$(echo -e "$options" | rofi -dmenu -p "DPI for $device_name")
[ -z "$dpi" ] && exit 0

# Применяем
razer-cli --device "$device_name" --dpi "$dpi" "$dpi"
notify-send "Razer" "$device_name → DPI set to $dpi"
