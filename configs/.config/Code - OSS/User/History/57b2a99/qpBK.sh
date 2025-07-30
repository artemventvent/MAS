#!/bin/bash

STATUS=$(playerctl --player=spotify status 2>/dev/null)
ARTIST=$(playerctl --player=spotify metadata --format '{{ artist }}' 2>/dev/null)
TITLE=$(playerctl --player=spotify metadata --format '{{ title }}' 2>/dev/null)
ALBUM_ART_URL=$(playerctl --player=spotify metadata --format '{{ mpris:artUrl }}' 2>/dev/null)

if [[ -z "$STATUS" || "$STATUS" == "Stopped" ]]; then
    echo '{"text":" Нет трека","tooltip":"Spotify не играет","class":"stopped"}'
    exit 0
fi

# Иконка Play/Pause
if [[ "$STATUS" == "Playing" ]]; then
    ICON=""
    CLASS="playing"
else
    ICON=""
    CLASS="paused"
fi

# Формируем текст для панели
TRACK="$ARTIST - $TITLE"
if [[ ${#TRACK} -gt 35 ]]; then
    TRACK="${TRACK:0:32}..."  # Обрезаем для панели
fi

# Делаем tooltip с полным названием
TOOLTIP="🎵 $ARTIST - $TITLE"

# Подгружаем обложку альбома и конвертим в Base64
if [[ -n "$ALBUM_ART_URL" ]]; then
    TMP_IMG="/tmp/spotify_cover.jpg"
    curl -s -o "$TMP_IMG" "$ALBUM_ART_URL"
    if [[ -f "$TMP_IMG" ]]; then
        BASE64_IMG=$(base64 -w 0 "$TMP_IMG")
        TOOLTIP="$TOOLTIP\n\n<img src='data:image/jpeg;base64,$BASE64_IMG' width='128'/>"
    fi
fi

# JSON для Waybar
echo "{\"text\":\" $TRACK $ICON\",\"tooltip\":\"$TOOLTIP\",\"class\":\"spotify $CLASS\"}"
