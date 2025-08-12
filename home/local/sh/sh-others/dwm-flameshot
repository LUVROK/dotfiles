#!/bin/sh

# Получаем количество подключенных мониторов
connected_monitors=$(xrandr --query | grep " connected" | wc -l)

if [ "$connected_monitors" -gt 1 ]; then
    QT_AUTO_SCREEN_SCALE_FACTOR=1.5 QT_SCREEN_SCALE_FACTORS="" flameshot gui
else
    flameshot gui
fi