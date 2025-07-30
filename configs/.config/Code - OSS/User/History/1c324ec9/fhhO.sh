#!/bin/bash

STATUS=$(playerctl --player=spotify status 2>/dev/null)
if [[ "$STATUS" == "Playing" ]]; then
    ICON="⏸"
elif [[ "$STATUS" == "Paused" ]]; then
    ICON="▶"
else
    ICON=""
fi

echo "{\"text\":\"$ICON\",\"class\":\"spotify\"}"
