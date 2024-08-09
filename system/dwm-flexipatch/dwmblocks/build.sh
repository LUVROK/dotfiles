#!/bin/sh

# Компилируем программу dwmblocks из исходного файла dwmblocks.c
cc -o dwmblocks dwmblocks.c -pedantic -Wall -Wno-deprecated-declarations -Os -lX11

# Проверяем, была ли компиляция успешной
if [ $? -eq 0 ]; then
    echo "Компиляция прошла успешно."
else
    echo "Во время компиляции произошли ошибки."
fi