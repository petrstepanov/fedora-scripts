#!/bin/bash

# Backup default sound
sudo mv /usr/share/sounds/gnome/default/alerts/click.ogg /usr/share/sounds/gnome/default/alerts/click.bak.ogg
sudo cp ./click.ogg /usr/share/sounds/gnome/default/alerts/click.ogg

# Restart Gnome shell
killall -3 gnome-shell
