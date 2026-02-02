sketchybar --add item clock right                              \
           --set clock update_freq=1                            \
                       icon="󰥔"                                \
                       icon.font="$FONT:Bold:15.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xff6d8896                    \
                       label.font="$FONT:Medium:12.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=8                    \
                       background.color=0xff252731              \
                       background.height=33                     \
                       background.corner_radius=20              \
                       background.padding_right=8               \
                       icon.padding_left=16                     \
                       label.padding_right=16                   \
                       script="$PLUGIN_DIR/clock.sh"
