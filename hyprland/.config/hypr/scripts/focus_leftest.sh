#!/usr/bin/env bash

ACTIVE_JSON=$(hyprctl activewindow -j)

CURRENT_MONITOR=$(echo "$ACTIVE_JSON" | jq -r '.monitor')
CURRENT_WORKSPACE=$(echo "$ACTIVE_JSON" | jq -r '.workspace.id')

if [ "$CURRENT_WORKSPACE" = "null" ] || [ -z "$CURRENT_WORKSPACE" ]; then
    CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')
    CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitorID')
fi

LEFTMOST_ID=$(hyprctl clients -j | jq -r "
  [ .[] | select(.monitor == $CURRENT_MONITOR and .workspace.id == $CURRENT_WORKSPACE) ]
  | min_by(.at[0])
  | .address
")

if [ -n "$LEFTMOST_ID" ] && [ "$LEFTMOST_ID" != "null" ]; then
    hyprctl dispatch "hl.dsp.focus({ window = \"address:$LEFTMOST_ID\" })"
fi
