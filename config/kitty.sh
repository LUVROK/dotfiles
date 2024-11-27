#!/bin/sh

# Заголовок окна
WINDOW_TITLE="QuickTerminal"

# Размер окна (ширина x высота)
WINDOW_WIDTH=800
WINDOW_HEIGHT=600

# Функция запуска Kitty
launch_kitty() {
    # Запускаем Kitty с заданными размерами и заголовком
    kitty --single-instance \
          --instance-group quickterm \
          --title "$WINDOW_TITLE" \
          --directory "$HOME" \
          tmux new -A -s quickterm &
    
    # Ждём немного, чтобы окно успело открыться
    sleep 0.5
    
    # Получаем ID только что запущенного окна
    local window_id=$(get_window_id)
    
    if [ -n "$window_id" ]; then
        center_window "$window_id"
    fi
}

# Функция для поиска окна по заголовку
get_window_id() {
    wmctrl -l | grep "$WINDOW_TITLE" | awk '{print $1}'
}

# Функция центрирования окна
center_window() {
    local window_id=$1
    # Получаем разрешение экрана
    local screen_width=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d 'x' -f1)
    local screen_height=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d 'x' -f2)
    
    # Вычисляем позицию для центрирования
    local pos_x=$(( (screen_width - WINDOW_WIDTH) / 2 ))
    local pos_y=$(( (screen_height - WINDOW_HEIGHT) / 2 ))
    
    # Перемещаем окно
    wmctrl -i -r "$window_id" -e 0,$pos_x,$pos_y,-1,-1
}

# Функция переключения окна
toggle_window() {
    local window_id=$1
    if [ -z "$window_id" ]; then
        launch_kitty
    else
        # Проверяем, свернуто окно или нет
        local state=$(xprop -id "$window_id" | grep "_NET_WM_STATE_HIDDEN")
        if [ -n "$state" ]; then
            # Если окно свернуто, разворачиваем
            wmctrl -i -a "$window_id"
        else
            # Если окно активно, сворачиваем
            wmctrl -i -r "$window_id" -b add,hidden
        fi
    fi
}

# Получаем ID окна
WINDOW_ID=$(get_window_id)

# Выполняем переключение
toggle_window "$WINDOW_ID"
