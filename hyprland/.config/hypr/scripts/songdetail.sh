#!/usr/bin/env bash

set -e

SONG=$(playerctl metadata --format '{{ title }} - {{artist}}' 2>/dev/null || '')
echo "Playing: $SONG"
