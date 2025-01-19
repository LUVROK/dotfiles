# #!/bin/sh

# # Show wifi 📶 and percent strength or 📡 if none.
# # Show 🌐 if connected to ethernet or ❎ if none.
# # Show 🔒 if a vpn connection is active

# case $BLOCK_BUTTON in
#   1) ${TERMINAL} -e "nmtui" ;;
# 	3) notify-send "🌐 Internet module" "\- Click to connect
# 📡: no wifi connection
# 📶: wifi connection with quality
# ❎: no ethernet11
# 🌐: ethernet working
# 🔒: vpn is active
# " ;;
# 	6) "$TERMINAL" -e "$EDITOR $0" ;;
# esac

# case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
# 	down) wifiicon="📡 " ;;
# 	up) wifiicon="$(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "%" }' /proc/net/wireless)" ;;
# esac

# printf "%s%s%s" "$wifiicon" "$(sed "s/down/❎/;s/up/🌐/" /sys/class/net/e*/operstate 2>/dev/null)" "$(sed "s/.*/🔒/" /sys/class/net/tun*/operstate 2>/dev/null)"

#!/bin/bash

# Функция для отображения даты и времени
get_date_time() {
    date +"%Y-%m-%d %H:%M:%S"
}

# Обработка клика
case "$1" in
    1) # ЛКМ
        (echo "^fg(#ffffff)^bg(#000000)"; cal; sleep 10) | dzen2 -p -x "1000" -y "20" -w "250" -h "200" -l "7" -sa 'c' -e 'onstart=uncollapse,hide' &
        ;;
    *) # Обновление даты и времени
        echo "$(get_date_time)"
        ;;
esac