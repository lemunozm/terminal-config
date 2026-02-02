sketchybar --add item battery right                              \
           --set battery update_freq=10                          \
                       icon.font="$FONT:Bold:15.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xff9ac868                    \
                       icon.y_offset=1                          \
                       label.font="$FONT:Medium:12.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=8                    \
                       background.color=0xff252731              \
                       background.height=33                     \
                       background.corner_radius=20              \
                       background.padding_right=3               \
                       icon.padding_left=16                     \
                       label.padding_right=16                   \
                       script="$PLUGIN_DIR/battery.sh"          \
           --subscribe battery system_woke power_source_change
