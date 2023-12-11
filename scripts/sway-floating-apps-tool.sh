#!/usr/bin/env bash


# select visible, floating window
# swaymsg -t get_tree | jq -r '..|try select((.type=="floating_con") and .visible)'

# select id of visible, floating window
#swaymsg -t get_tree | jq -r '..|try select((.type=="floating_con") and .visible).id'

sway_tree="$(swaymsg -t get_tree)"
container_id="$(echo $sway_tree | jq -r '.. | try select((.type=="floating_con") and .visible).id')"
display_width="$(echo $sway_tree | jq -r '..| try select((.type=="floating_con") and .visible).geometry.width')"
display_height="$(echo $sway_tree | jq -r '..| try select((.type=="floating_con") and .visible).geometry.height')"

echo "Width: $display_width | " $(($display_width / 2))
echo "Height: $display_height | " $((display_height / 2))
#swaymsg [con_id=$container_id] border $new_border_mode

swaymsg "[con_id="$container_id"] move position $(($display_width / 2)) $((display_height / 2))"


