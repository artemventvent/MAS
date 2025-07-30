#!/bin/bash

count=$(checkupdates 2> /dev/null | wc -l)

if [[ $count -gt 0 ]]; then
    echo "{\"text\": \" $count\", \"tooltip\": \"$count updates available\", \"class\": \"updates\"}"
else
    echo "{\"text\": \"󰄬\", \"tooltip\": \"System up to date\", \"class\": \"no-updates\"}"
fi