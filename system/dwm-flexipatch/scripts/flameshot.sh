#!/bin/sh

# Получаем количество подключенных мониторов
connected_monitors=$(xrandr --query | grep " connected" | wc -l)

if [ "$connected_monitors" -gt 1 ]; then
    # Устанавливаем переменную окружения и запускаем flameshot
    QT_AUTO_SCREEN_SCALE_FACTOR=1.5 QT_SCREEN_SCALE_FACTORS="" flameshot gui
else
    # Запускаем flameshot без переменной окружения
    flameshot gui
fi