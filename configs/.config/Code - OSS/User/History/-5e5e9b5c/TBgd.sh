#!/bin/bash

CITY="cherepovets"
URL="https://wttr.in/${CITY}?format=%c+%t"

WEATHER=$(curl -s -H "Accept-Language: en" -A "Mozilla/5.0" "$URL")

if [ -z "$WEATHER" ]; then
    echo '{"text":"🌥","tooltip":"No data","class":"error"}'
    exit 0
fi

echo "{\"text\":\"$WEATHER\",\"tooltip\":\"Weather: $WEATHER\",\"class\":\"weather\"}"