#!/bin/bash

for sid in 1 2 3 4 5 6 7 8 9 \
           A B C D E F G I M N O P Q R S T U V W X Y Z; do
  sketchybar --add item space."$sid" center \
             --set space."$sid" \
             icon="$sid" \
             icon.color=0xff583794 \
             icon.highlight_color=0xffe0af68 \
             icon.font="$FONT:Bold:13.0" \
             icon.width=28 \
             icon.align=center \
             icon.padding_left=0 \
             icon.padding_right=0 \
             label.drawing=off \
             background.color=0xff252630 \
             background.corner_radius=33 \
             background.height=33 \
             background.drawing=off \
             drawing=off \
             click_script="aerospace workspace $sid"
done

sketchybar --add item aerospace_trigger center \
           --set aerospace_trigger \
           drawing=off \
           script="$PLUGIN_DIR/aerospace.sh" \
           --subscribe aerospace_trigger aerospace_workspace_change
