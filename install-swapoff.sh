#!/bin/bash

mkdir -p $HOME/bin
cp ./HOME/bin/swapoff.sh $HOME/bin/
chmod +x $HOME/bin/swapoff.sh

# Create desktop launcher for .root files
launcher="$HOME/.config/autostart/swapoff.desktop"
rm -f $launcher
echo "[Desktop Entry]" > $launcher
echo "Type=Application" >> $launcher
echo "Name=SwapOff" >> $launcher
echo "Comment=Turn off the swap" >> $launcher
echo "Icon=drive-harddisk" >> $launcher
echo "Exec=bash -c 'sleep 20 && pkexec swapoff.sh'" >> $launcher
echo "Categories=Utility" >> $launcher

chmod +x $launcher
