#!/bin/bash
set -e

SERVICE_NAME="all_players_hotkeys"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="/userdata/system/all-players-hotkeys"
SERVICES_DIR="/userdata/system/services"

batocera-services stop "$SERVICE_NAME" 2>/dev/null || true

mkdir -p "$INSTALL_DIR" "$SERVICES_DIR"
cp "$SOURCE_DIR/bin/all-players-hotkeys-generate" "$INSTALL_DIR/all-players-hotkeys-generate"
cp "$SOURCE_DIR/services/$SERVICE_NAME" "$SERVICES_DIR/$SERVICE_NAME"
chmod 755 "$INSTALL_DIR/all-players-hotkeys-generate" "$SERVICES_DIR/$SERVICE_NAME"

batocera-services enable "$SERVICE_NAME"
batocera-services start "$SERVICE_NAME"
batocera-services status "$SERVICE_NAME"
