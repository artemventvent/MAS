#!/bin/bash

STATUS=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$STATUS" == "Playing" ]]; then
    ICON=""  # pause
elif [[ "$STATUS" == "Paused" ]]; then
    ICON=""  # play
else
    echo '{"text":" Нет трека","class":"stopped"}'
    exit 0
fi

# Получаем трек без битого UTF-8 (обрезаем по словам)
TRACK=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' | awk '{ if(length($0)>40) $0=substr($0,1,37)"..."; print }')

# Экранируем кавычки
TRACK=$(echo "$TRACK" | sed 's/"/\\"/g')

echo "{\"text\":\"  $TRACK $ICON\",\"class\":\"spotify\"}"