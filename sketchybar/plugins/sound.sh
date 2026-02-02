#!/bin/bash

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$MUTED" != "false" ]; then
  ICON="󰖁"
else
  case ${VOLUME} in
    [7-9][0-9]|100) ICON="󰕾" ;;
    [3-6][0-9])     ICON="󰖀" ;;
    [1-2][0-9])     ICON="󰕿" ;;
    [0-9])          ICON="󰕿" ;;
    *)              ICON="󰖁" ;;
  esac
fi

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME"
