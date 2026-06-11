#!/bin/bash

COLOR_FILE="$HOME/.cache/DankMaterialShell/dms-colors.json"

if [ ! -f "$COLOR_FILE" ]; then
  echo "Ошибка: Файл $COLOR_FILE не найден!"
  exit 1
fi

HEX_COLOR=$(jq -r '.colors.dark.inverse_primary' "$COLOR_FILE")

if [ -z "$HEX_COLOR" ] || [ "$HEX_COLOR" == "null" ]; then
  echo "Ошибка: Не удалось получить цвет из JSON!"
  exit 1
fi

LIQUID_COLOR=${HEX_COLOR//#/}

liquidctl set sync color fixed "$LIQUID_COLOR"

echo "Успешно! Установлен цвет подсветки: $LIQUID_COLOR"
