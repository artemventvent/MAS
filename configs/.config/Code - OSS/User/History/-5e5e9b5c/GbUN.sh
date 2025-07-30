#!/bin/bash

# Координаты Череповца
LAT="59.127881"
LON="37.893373"
URL="https://wttr.in/@${LAT},${LON}"

WEATHER=$(curl -s -L "${URL}?format=%c+%t&lang=ru")
DETAILS=$(curl -s -L "${URL}?0Q&lang=ru")

if [[ -z "$WEATHER" || "$WEATHER" == *"Unknown"* ]]; then
    WEATHER="🌥 +??°C"
    DETAILS="Не удалось получить данные"
fi

DETAILS=$(echo "$DETAILS" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')

echo "{\"text\":\"$WEATHER\",\"tooltip\":\"$DETAILS\",\"class\":\"weather\"}"