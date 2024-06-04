#!/bin/bash

# Install
sudo dnf install onedrive
onedrive --resync

# Autostart
cp ./HOME/.config/autostart/onedrive.desktop $HOME/.config/autostart/

echo "Please log out and log in"
