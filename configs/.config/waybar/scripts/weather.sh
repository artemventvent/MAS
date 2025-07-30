#!/bin/bash

# Координаты Череповца
LAT="59.127881"
LON="37.893373"
URL="https://wttr.in/@${LAT},${LON}"

# Получаем погоду (например: "☀️   +21°C" с лишними пробелами)
WEATHER=$(curl -s -L "${URL}?format=%c+%t&lang=ru" | sed 's/ //g')

# Если нет данных
if [[ -z "$WEATHER" ]]; then
    WEATHER="🌥+??°C"
    CLASS="unknown"
else
    TEMP=$(echo "$WEATHER" | grep -oE '[-+]?[0-9]+' || echo 0)

    if (( TEMP <= 0 )); then
        CLASS="cold"
    elif (( TEMP <= 20 )); then
        CLASS="normal"
    elif (( TEMP <= 25 )); then
        CLASS="warm"
    else
        CLASS="hot"
    fi
fi

echo "{\"text\":\"$WEATHER\",\"class\":\"$CLASS\"}"