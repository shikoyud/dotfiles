#!/usr/bin/env bash

CURRENT_WS=$(hyprctl activeworkspace -j | jq '.id')

TARGET_ADDR=$(
    hyprctl clients -j |
    jq -r --argjson ws "$CURRENT_WS" '
        map(select(.workspace.id == $ws and .focusHistoryID > 0))
        | sort_by(.focusHistoryID)
        | .[0].address // empty
    '
)

if [ -n "$TARGET_ADDR" ]; then
    hyprctl dispatch "hl.dsp.focus({ window = \"address:$TARGET_ADDR\" })"
fi
