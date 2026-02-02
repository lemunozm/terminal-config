### CPU Widget ###
sketchybar --add item cpu right                                  \
           --set cpu   update_freq=10                            \
                       icon="󰍛"                                \
                       icon.font="$FONT:Bold:11.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xfff6768e                    \
                       label.font="$FONT:Medium:10.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=4                    \
                       background.color=0xff252731              \
                       background.height=19                     \
                       background.corner_radius=12              \
                       background.padding_right=3               \
                       icon.padding_left=8                      \
                       label.padding_right=8                    \
                       script="$PLUGIN_DIR/cpu.sh"

### Memory Widget ###
sketchybar --add item mem right                                  \
           --set mem   update_freq=10                            \
                       icon="󰘚"                                \
                       icon.font="$FONT:Bold:11.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xff4ed2e3                    \
                       label.font="$FONT:Medium:10.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=4                    \
                       background.color=0xff252731              \
                       background.height=19                     \
                       background.corner_radius=12              \
                       background.padding_right=3               \
                       icon.padding_left=8                      \
                       label.padding_right=8                    \
                       script="$PLUGIN_DIR/mem.sh"

### Disk Widget ###
sketchybar --add item ssd right                                  \
           --set ssd   update_freq=10                            \
                       icon="󰋊"                                \
                       icon.font="$FONT:Bold:11.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xfffbc02d                    \
                       label.font="$FONT:Medium:10.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=4                    \
                       background.color=0xff252731              \
                       background.height=19                     \
                       background.corner_radius=12              \
                       background.padding_right=3               \
                       icon.padding_left=8                      \
                       label.padding_right=8                    \
                       script="$PLUGIN_DIR/disk.sh"
