#!/bin/bash

# Install conky
sudo dnf install conky

# Copy config file
cp ./HOME/.config/conky.conf $HOME/.config/

# Autostart
cp ./HOME/.config/autostart/conky.desktop $HOME/.config/autostart/
