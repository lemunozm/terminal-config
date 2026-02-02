sketchybar --add item battery right                              \
           --set battery update_freq=10                          \
                       icon.font="$FONT:Bold:11.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xff9ac868                    \
                       label.font="$FONT:Medium:10.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=4                    \
                       background.color=0xff252731              \
                       background.height=19                     \
                       background.corner_radius=12              \
                       background.padding_right=3               \
                       icon.padding_left=8                      \
                       label.padding_right=8                    \
                       script="$PLUGIN_DIR/battery.sh"          \
           --subscribe battery system_woke power_source_change
