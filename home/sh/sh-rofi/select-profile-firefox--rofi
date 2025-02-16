# !/bin/sh

PROFILES=$(awk -F= '/^\[Profile/ {profile=$0} /Name=/ {print $2}' ~/.mozilla/firefox/profiles.ini)
COUNT_OF_PROFILES=$(awk -F= '/^\[Profile/ {count++} END {print count}' ~/.mozilla/firefox/profiles.ini)
WINDOW_WIDTH=$(xdotool getactivewindow getwindowgeometry --shell | grep WIDTH | cut -d '=' -f2)

DIR="$(dirname "$0")"

rofi_command="rofi -theme /home/dash/HOME/dotfiles/home/programs/rofi/config/firefox-profiles-menu.rasi"

ddir="$HOME/.config/rofi/config"

# options="XMR\nLTC\nBTC\nETC\nZEC\nETH\nBCH\nXRPH\n1INCH"
chosen="$(echo -e "$PROFILES" | $rofi_command -dmenu -selected-row $COUNT_OF_PROFILES)"

if [ "$WINDOW_WIDTH" -gt 2560 ]; then
    DPI=1
else
    DPI=0.8
fi

PROFILE_DIR=$(echo "$HOME/.mozilla/firefox/"*"$chosen")

echo "user_pref('layout.css.devPixelsPerPx', '$DPI');" >> "$PROFILE_DIR/user.js"

# check if profile already running
if pgrep -f "firefox.*-P $chosen" > /dev/null; then
    notify-send "Firefox Profile Warning" "Profile '$chosen' is already running!"
else
    firefox --no-remote -P "$chosen" 2>/dev/null
fi
