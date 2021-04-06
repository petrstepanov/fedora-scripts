#!/bin/bash

# Install Autokey folder
echo "Installing Eclipse keybindings..."
mkdir -p ~/.config/autokey/data
cp -r ./gnome-macos-phrases-extra/ ~/.config/autokey/data/

# Activate window menu interferes with Eclipse Context assist <Alt>+Space
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"

echo "Installing hand-made A1048 keyboard tweaks..."
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['XF86Launch5']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['XF86Launch6']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['XF86Launch7']"

echo "Go to Eclipse -> Window -> Preferences -> General -> Keys"
echo "* Search for 'Content Assist', add 'Alt+Space' binding."
echo "* Search for 'Toggle Source/Header, add 'Alt+Tab' binding."
