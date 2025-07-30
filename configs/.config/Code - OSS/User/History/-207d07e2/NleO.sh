#!/bin/bash

# Получаем статус Spotify
STATUS=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$STATUS" == "Playing" ]]; then
    ICON=""  # pause
elif [[ "$STATUS" == "Paused" ]]; then
    ICON=""  # play
else
    echo '{"text":" Нет трека","class":"stopped"}'
    exit 0
fi

# Трек (исполнитель - название)
TRACK=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' | cut -c1-40)

echo "{\"text\":\" $TRACK $ICON\",\"class\":\"spotify\"}"
