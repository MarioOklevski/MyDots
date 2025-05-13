#!/bin/bash

# Get the battery percentage using acpi
battery_level=$(acpi -b | grep -oP '\d+(?=%)')

# Check if the battery level is below 15%
if [ "$battery_level" -le 15 ]; then
    # Send a notification with mako
    notify-send -h string:x-canonical-private-syncronous:sys-notify -u low "Battery is below 15%!"
fi
