#!/bin/bash

# Get focused workspace from the event env var, or query aerospace directly
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

# Get non-empty workspaces
NON_EMPTY=$(aerospace list-workspaces --all --empty no)

# All known workspaces (must match sketchybarrc)
ALL_WORKSPACES="1 2 3 4 5 6 7 8 9 A B C D E F G I M N O P Q R S T U V W X Y Z"

args=()
for sid in $ALL_WORKSPACES; do
  if [ "$sid" = "$FOCUSED" ]; then
    args+=(--set space."$sid" drawing=on background.drawing=on)
  elif echo "$NON_EMPTY" | grep -qx "$sid"; then
    args+=(--set space."$sid" drawing=on background.drawing=off)
  else
    args+=(--set space."$sid" drawing=off)
  fi
done

sketchybar "${args[@]}"
