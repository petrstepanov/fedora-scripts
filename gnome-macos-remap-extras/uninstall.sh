#!/bin/bash

# Uninstall Autokey folder
echo "Uninstalling autokey phrases..."
rm -rf ~/.config/autokey/data/gnome-macos-phrases-extra

# Revert standard GNOME keybindings
echo "Reverting default GNOME keybindings..."
gsettings reset org.gnome.desktop.wm.keybindings activate-window-menu

gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-mute
gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-down
gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-up

echo ""
echo "Uninstall complete."
