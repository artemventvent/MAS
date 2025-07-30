#!/bin/bash

# Координаты Череповца
LAT="59.127881"
LON="37.893373"
URL="https://wttr.in/@${LAT},${LON}"

# Краткая погода (иконка + температура)
WEATHER=$(curl -s -L "${URL}?format=%c+%t&lang=ru")

# Подробная инфа для tooltip
DETAILS=$(curl -s -L "${URL}?0Q&lang=ru")

if [[ -z "$WEATHER" ]]; then
    echo '{"text":"🌥","tooltip":"Нет данных","class":"error"}'
    exit 0
fi

# JSON для Waybar
echo "{\"text\":\"$WEATHER\",\"tooltip\":\"$DETAILS\",\"class\":\"weather\"}"
