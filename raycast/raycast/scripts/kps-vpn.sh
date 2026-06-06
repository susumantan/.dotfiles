#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kopnus VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🛡️
# @raycast.packageName Kopnus, VPN

# Documentation:
# @raycast.description Toggles the Kopnus openfortivpn connection
# @raycast.author SusuMantan
# @raycast.authorURL github.com/susumantan

if ! command -v openfortivpn >/dev/null 2>&1; then
    echo "openfortivpn is not installed. Please install it to use this script."
    exit 1
fi

CONFIG_PATH="$HOME/.config/openfortivpn/kopnus.conf"
LOG_FILE="$HOME/.config/openfortivpn/kopnus.log"

if pgrep openfortivpn >/dev/null 2>&1; then
    sudo pkill openfortivpn
    echo "🔴 VPN Disconnected"
else
    if [ ! -f "$CONFIG_PATH" ]; then
        echo "Error: Missing config at $CONFIG_PATH"
        exit 1
    fi

    > "$LOG_FILE"

    sudo /opt/homebrew/bin/openfortivpn --config "$CONFIG_PATH" > "$LOG_FILE" 2>&1 &

    sleep 3
    if grep -q "Tunnel is up and running" "$LOG_FILE"; then
        echo "🟢 VPN Connected"
    else
        echo "🔴 Connection failed. Check $LOG_FILE."
        sudo pkill openfortivpn
        exit 1
    fi
fi