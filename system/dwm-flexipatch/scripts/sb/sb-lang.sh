#!/usr/bin/env bash

notify-send '11'

status=$(xset -q | grep LED)
led_indicator=$(echo $status | awk '{ print substr($10, 5, 1) }')

if [ "$led_indicator" -eq "1" ]; then
    echo "[RU]"
else
    echo "[EN]"
fi

# notify-send 'sdlksdjf'

# current_layout() {
#     # setxkbmap -query | grep 'layout:' | sed 's/layout:\s\+//'

#     status=$(xset -q | grep LED)
#     led_indicator=$(echo $status | awk '{ print substr($10, 5, 1) }')

#     if [ "$led_indicator" -eq "1" ]; then
#         echo "[RU]"
#     else
#         echo "[EN]"
#     fi
# }

# handle_click() {
#     if [[ "$(current_layout)" == 'us' ]]; then
#         setxkbmap -layout ru
#     else
#         setxkbmap -layout us
#     fi
# }

# render() {
#     current_layout
# }

# case "$BUTTON" in
#     1) handle_click ;;
# esac

# render