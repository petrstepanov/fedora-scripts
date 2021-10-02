#!/bin/bash

mkdir -p ~/bin
cp ./bin/chrome-crash-fix.sh ~/bin
chmod +x ~/bin/chrome-crash-fix.sh

# Create desktop launcher for .root files
launcher="$HOME/.config/autostart/chrome-crash-fix.desktop"
rm -f $launcher
echo "[Desktop Entry]" >> $launcher
echo "Type=Application" >> $launcher
echo "Name=Chromium Crash Fix" >> $launcher
echo "Comment=Chromium didn't shut down correctly fix" >> $launcher
echo "Icon=gnome-chromium" >> $launcher
echo "Exec=chrome-crash-fix.sh" >> $launcher
