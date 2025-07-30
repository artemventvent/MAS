#!/bin/bash

if ip link show wg0 &>/dev/null; then
    echo '{"text": " VPN", "class": "connected"}'
else
    echo '{"text": " VPN", "class": "disconnected"}'
fi
