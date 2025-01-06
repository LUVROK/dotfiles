#!/usr/bin/env bash

echo '111'

notify-send $@

 case "$BUTTON" in
    1) notify-send 'Left Click' ;;
    2) notify-send 'Middle Click' ;;
    3) notify-send 'Right Click' ;;
    *) notify-send -t 2000 "Clicked Button: $BUTTON" &
esac

# notify-send '1'