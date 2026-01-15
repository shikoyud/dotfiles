#!/usr/bin/env bash

set -e

SPEAKER="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
HEADSET="alsa_output.usb-Logitech_G_series_G435_Wireless_Gaming_Headset_202105190004-00.analog-stereo"

RUNNING_SINK=$(pactl list short sinks | awk '$NF=="RUNNING"{print $2}')

if [ $RUNNING_SINK = $SPEAKER ]; then
	pactl set-default-sink $HEADSET
else
	pactl set-default-sink $SPEAKER
fi
