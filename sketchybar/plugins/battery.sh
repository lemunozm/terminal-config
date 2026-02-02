#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$BATT_PERCENT" = "" ]; then
  exit 0
fi

if [ "$CHARGING" != "" ]; then
  sketchybar --set "$NAME" icon="󰂄" label="${BATT_PERCENT}"
  exit 0
fi

case ${BATT_PERCENT} in
  100)     ICON="󰁹"; COLOR="0xff9ac868" ;;
  9[0-9])  ICON="󰂂"; COLOR="0xff9ac868" ;;
  8[0-9])  ICON="󰂁"; COLOR="0xff9ac868" ;;
  7[0-9])  ICON="󰂀"; COLOR="0xfffbc02d" ;;
  6[0-9])  ICON="󰁿"; COLOR="0xfffbc02d" ;;
  5[0-9])  ICON="󰁾"; COLOR="0xfffbc02d" ;;
  4[0-9])  ICON="󰁽"; COLOR="0xfffbc02d" ;;
  3[0-9])  ICON="󰁼"; COLOR="0xfffbc02d" ;;
  2[0-9])  ICON="󰁻"; COLOR="0xfffbc02d" ;;
  1[0-9])  ICON="󰁺"; COLOR="0xfff65e51" ;;
  *)       ICON="󰂎"; COLOR="0xfff65e51" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${BATT_PERCENT}" icon.color="$COLOR"
