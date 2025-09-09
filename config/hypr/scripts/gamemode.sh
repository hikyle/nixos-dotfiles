#!/bin/bash

if [ -f $HOME/.config/gamemode-enabled ]; then
    hyprctl reload
    rm $HOME/.config/gamemode-enabled
else
    hyprctl --batch "\
    keyword animations:enabled 0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:rounding 0"
    touch $HOME/.config/gamemode-enabled
fi
