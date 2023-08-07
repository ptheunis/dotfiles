#!/usr/bin/env bash


DIR="$HOME/.config/polybar"
#terminate running bars
killall -q polybar

#wait untill done
while pgrep -u $UID -x polybar >/dev/null; do sleep1; done

#launch bar
polybar -q main -c "$DIR/config.ini" &
