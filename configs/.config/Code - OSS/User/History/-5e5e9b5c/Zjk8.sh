#!/bin/bash

# Координаты Череповца
LAT="59.127881"
LON="37.893373"
URL="https://wttr.in/@${LAT},${LON}"

# Получаем погоду (иконка + температура)
WEATHER=$(curl -s -L "${URL}?format=%c+%t&lang=ru")

if [[ -z "$WEATHER" ]]; then
    WEATHER="🌥 +??°C"
fi

# Выводим JSON для Waybar
echo "{\"text\":\"$WEATHER\",\"class\":\"weather\"}"