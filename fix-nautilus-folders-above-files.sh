#!/bin/bash

mkdir -p $HOME/bin
cp ./HOME/bin/nautilus-sort-fix.sh $HOME/bin/nautilus-sort-fix.sh
chmod +x $HOME/bin/nautilus-sort-fix.sh

# Create desktop launcher for .root files
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
