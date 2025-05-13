#!/bin/bash
streamer -c /dev/video0 -b 16 -o ~/Downloads/outfile.jpeg
mpv ~/Downloads/camera.mp3
kitty -e mpv ~/Downloads/haha.mp3 & hyprlock
