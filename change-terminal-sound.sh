#!/bin/bash

# Change Drip in freedesktop sound scheme (used in terminal?)
## Backup old sound 
#sudo mv /usr/share/sounds/freedesktop/stereo/bell.oga /usr/share/sounds/freedesktop/stereo/bell.bak.oga
#sudo cp /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga /usr/share/sounds/freedesktop/stereo/bell.oga

# Change Drip in GNOME settings
## Backup default sound
sudo mv /usr/share/sounds/gnome/default/alerts/drip.ogg /usr/share/sounds/gnome/default/alerts/drip.bak.ogg
sudo cp /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga /usr/share/sounds/gnome/default/alerts/drip.ogg

# Restart Gnome shell
killall -3 gnome-shell
