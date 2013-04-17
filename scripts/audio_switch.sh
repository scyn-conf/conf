#!/bin/bash
# File: audio_switch.sh
# Project: audioswitch
# Brief:
# Version:
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#
self=$0
switch_to=$1

pacmd "set-default-sink $switch_to"
for app in `pacmd list-sink-inputs | sed -n -e 's/index:[[:space:]]\([[:digit:]]\)/\1/p'`; do
	pacmd "move-sink-input $app $switch_to"
done
