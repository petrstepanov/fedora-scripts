#!/bin/bash

mkdir -p $HOME/.local/bin
cp ./HOME/bin/nautilus-sort-fix.sh $HOME/.local/bin/nautilus-sort-fix.sh
chmod +x $HOME/.local/bin/nautilus-sort-fix.sh

# Create desktop launcher
launcher="$HOME/.config/autostart/nautilus-sort-fix.desktop"
rm -f $launcher
echo "[Desktop Entry]" >> $launcher
echo "Type=Application" >> $launcher
echo "Name=Fix Folders Sorting" >> $launcher
echo "Comment=Fix Sort Folders Before Files" >> $launcher
echo "Icon=folder" >> $launcher
echo "Exec=nautilus-sort-fix.sh" >> $launcher
echo "Categories=Utility" >> $launcher

chmod +x $launcher
