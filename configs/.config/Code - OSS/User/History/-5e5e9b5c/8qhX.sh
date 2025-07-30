#!/bin/bash

# Город (или оставить пустым для автоопределения по IP)
CITY=""

# Получаем погоду в формате "☀️ +15°C"
WEATHER=$(curl -s "wttr.in/cherepovets?format=%c+%t")

# Если curl не смог загрузить
# if [ -z "$WEATHER" ]; then
#     echo '{"text":"🌥","tooltip":"No data","class":"error"}'
#     exit 0
# fi

# Вывод в формате JSON для Waybar
echo "{\"text\":\"$WEATHER\",\"tooltip\":\"Weather: $WEATHER\",\"class\":\"weather\"}"
