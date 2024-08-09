#!/bin/sh

status=$(xset -q | grep LED)
led_indicator=$(echo $status | awk '{ print substr($10, 5, 1) }')

if [ "$led_indicator" -eq "1" ]; then
    echo "[RU]"
else
    echo "[EN]"
fi