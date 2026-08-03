#!/usr/bin/env bash

set -euo pipefail

SPEAKER="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
HEADSET="alsa_output.usb-Logitech_G_series_G435_Wireless_Gaming_Headset_202105190004-00.analog-stereo"

DEFAULT_SINK=$(pactl get-default-sink)

if [[ "$DEFAULT_SINK" = "$SPEAKER" ]]; then
	pactl set-default-sink $HEADSET
  hyprctl notify 1 1500 "rgb(40e0d0)" "Switched to headset"
else
	pactl set-default-sink $SPEAKER
  hyprctl notify 1 1500 "rgb(ff9922)" "Switched to speaker"
fi
