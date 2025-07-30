#!/bin/bash

# Координаты Череповца
LAT="59.127881"
LON="37.893373"
URL="https://wttr.in/@${LAT},${LON}"

# Получаем температуру (пример: ☀️ +21°C)
WEATHER=$(curl -s -L "${URL}?format=%c+%t&lang=ru")

if [[ -z "$WEATHER" ]]; then
    WEATHER="🌥 +??°C"
    CLASS="unknown"
else
    # Извлекаем число температуры (сохраняем знак)
    TEMP=$(echo "$WEATHER" | grep -oE '[-+]?[0-9]+' || echo 0)

    if (( TEMP <= 0 )); then
        CLASS="cold"
    elif (( TEMP <= 20 )); then
        CLASS="normal"
    elif (( TEMP <= 26 )); then
        CLASS="warm"
    else
        CLASS="hot"
    fi
fi

echo "{\"text\":\"$WEATHER\",\"class\":\"$CLASS\"}"