sketchybar --add item front_app left                             \
           --set front_app icon.drawing=off                      \
                       label.font="$FONT:Medium:10.0"            \
                       label.color=0xffdfe1ea                    \
                       background.color=0xff252731               \
                       background.height=19                      \
                       background.corner_radius=12               \
                       background.padding_right=3                \
                       label.padding_left=8                      \
                       label.padding_right=8                     \
                       script="$PLUGIN_DIR/front_app.sh"         \
           --subscribe front_app front_app_switched
