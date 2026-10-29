#!/bin/bash

SERVICE_NAME="all_players_hotkeys"

batocera-services stop "$SERVICE_NAME"
batocera-services disable "$SERVICE_NAME"
rm -f "/userdata/system/services/$SERVICE_NAME"
rm -rf "/userdata/system/all-players-hotkeys" "/var/run/all-players-hotkeys"
rm -f "/userdata/system/logs/all-players-hotkeys.log"
echo "${SERVICE_NAME}: removed"
