#!/bin/sh

nvtop -s 2>/dev/null \
| jq -r '
  map(select(.device_name | test("NVIDIA"))) | .[0] |
  {
    percentage: (.gpu_util | rtrimstr("%") | tonumber),
    alt: (.temp | rtrimstr("C") | tonumber),
		text: (.power_draw | rtrimstr("W") | tonumber),
  }
'

