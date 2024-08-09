#!/bin/sh
# Получаем процент заряда батареи
bat_percentage=$(upower -i "$(upower -e | grep BAT)" | grep percentage | awk '{print $2}' | tr -d '%\n')

# Определяем иконку в зависимости от уровня заряда
if [ "$bat_percentage" -ge 90 ]; then
    icon=""  # Полностью заряжена
elif [ "$bat_percentage" -ge 75 ]; then
    icon=""  # Заряжена более чем на три четверти
elif [ "$bat_percentage" -ge 50 ]; then
    icon=""  # Заряжена более чем на половину
elif [ "$bat_percentage" -ge 20 ]; then
    icon=""  # Заряжена менее чем на половину
else
    icon=""  # Почти пустая
fi

# Выводим иконку и процент заряда
printf "%s %s%%" "$icon" "$bat_percentage"