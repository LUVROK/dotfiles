#!/bin/sh

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # bar=$(seq -s "─" $(($volume / 2)) | sed 's/[0-9]//g')
    # colored_bar="<span color='#00FF00'>$bar</span>"

    notify-send "Volume: $volume%" \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:"$volume" \
        --hint=int:value:"$volume" \
        --urgency=low

    # dunstify -u normal -h string:x-dunst-stack-tag:volume -h int:value:"$volume" "<span color='$color'>Volume: $volume%</span>"
}

function send_notification1 {
    volume=`get_volume`
    # bar=$(seq -s "─" $(($volume / 2)) | sed 's/[0-9]//g')
    # colored_bar="<span color='#00FF00'>$bar</span>"

    notify-send "Volume: $volume%" \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:"$volume" \
        --hint=int:value:"$volume" \
        --urgency=low

    # dunstify -u normal -h string:x-dunst-stack-tag:volume -h int:value:"$volume" "<span color='$color'>Volume: $volume%</span>"
}

case $1 in
    up)
        # Получаем текущий уровень громкости
        volume=$(get_volume)
        if [ "$volume" -lt 100 ]; then
            # Включаем звук (если он был выключен)
            pactl set-sink-mute @DEFAULT_SINK@ 0
            # Увеличиваем громкость (+2%)
            pactl set-sink-volume @DEFAULT_SINK@ +2%
            send_notification1
        fi
        ;;
    down)
        # Включаем звук (если он был выключен)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        # Уменьшаем громкость (-2%)
        pactl set-sink-volume @DEFAULT_SINK@ -2%
        send_notification
        ;;
    mute)
        # Переключаем режим mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if is_mute ; then
            notify-send "Volume: Mute" \
                --urgency=low
        else
            send_notification
        fi
        ;;
esac