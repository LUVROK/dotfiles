#!/usr/bin/env sh

# Замените путь на тот, где вы сохранили файл темы.
THEME_FILE="$HOME/.config/rofi/pinentry-wrapper.rasi"

# Запускаем pinentry-rofi, передавая ему опции Rofi через переменную среды.
ROFI_OPTIONS="-theme $THEME_FILE" pinentry-rofi "$@"