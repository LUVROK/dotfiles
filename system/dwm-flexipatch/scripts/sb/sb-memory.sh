#!/bin/sh

notify-send '1'

case $BLOCK_BUTTON in
	1) notify-send "🧠 Memory hogs" "$(ps axch -o cmd:15,%mem --sort=-%mem | head)" ;;
	2) setsid -f "$TERMINAL" -e htop ;;
	3) notify-send "🧠 Memory module" "\- Shows Memory Used/Total.
- Click to show memory hogs.
- Middle click to open htop." ;;
	6) "$TERMINAL" -e "$EDITOR $0" ;;
esac

echo free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed 's/i//g' | sed 's/,/./g'