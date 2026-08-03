#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
FOCUS_LEFTEST="$SCRIPT_DIR/focus_leftest.sh"

if hyprctl activewindow | grep -q "Invalid"; then
  if [ "$1" = "down" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "m+1" })' > /dev/null 2>&1
  elif [ "$1" = "up" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "m-1" })' > /dev/null 2>&1
  fi
  exit 0
fi

RESPONSE=$(hyprctl dispatch "hl.dsp.focus({ direction = \"$1\" })")
if [[ "$RESPONSE" == *"Nothing to focus"* ]];  then
  if [ "$1" = "down" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "m+1" })' > /dev/null 2>&1
  elif [ "$1" = "up" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "m-1" })' > /dev/null 2>&1
  elif [ "$1" = "left" ]; then
    hyprctl dispatch 'hl.dsp.focus({ monitor = "left" })' > /dev/null 2>&1
  elif [ "$1" = "right" ]; then
    RIGHT_MON=$(hyprctl dispatch 'hl.dsp.focus({ monitor = "right" })')
    if [[ "$RIGHT_MON" == *"monitor not found"* ]];  then
      "$FOCUS_LEFTEST"
    fi
  fi
fi
