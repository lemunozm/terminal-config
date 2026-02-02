#!/bin/bash

MEM=$(top -l 1 | grep -E "^PhysMem" | awk '{print $2}')

sketchybar --set "$NAME" label="$MEM"
