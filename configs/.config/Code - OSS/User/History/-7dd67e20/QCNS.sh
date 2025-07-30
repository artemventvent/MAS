#!/bin/bash

TRACK=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' | \
awk '{ if(length($0)>40) $0=substr($0,1,37)"..."; print }')
TRACK=$(echo "$TRACK" | sed 's/"/\\"/g')

if [[ -z "$TRACK" ]]; then
    TRACK="Нет трека"
fi

echo "{\"text\":\"$TRACK\",\"class\":\"spotify-track\"}"
