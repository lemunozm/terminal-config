sketchybar --add item clock right                              \
           --set clock update_freq=1                            \
                       icon="󰥔"                                \
                       icon.font="$FONT:Bold:11.0"              \
                       icon.padding_right=4                     \
                       icon.color=0xff6d8896                    \
                       label.font="$FONT:Medium:10.0"           \
                       label.color=0xffdfe1ea                   \
                       label.padding_right=4                    \
                       background.color=0xff252731              \
                       background.height=19                     \
                       background.corner_radius=12              \
                       background.padding_right=4               \
                       icon.padding_left=8                      \
                       label.padding_right=8                    \
                       script="$PLUGIN_DIR/clock.sh"
