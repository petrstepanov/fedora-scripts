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
#echo "Exec=pkexec sudo /home/$USER/bin/swapoff.sh" >> $launcher
echo "Exec=bash -c 'sleep 20 && pkexec sudo /home/petrstepanov/bin/swapoff.sh'" >> $launcher
echo "Categories=Utility" >> $launcher
echo "Terminal=false" >> $launcher
#echo "X-GNOME-Autostart-enabled=true" >> $launcher
#echo "X-GNOME-Autostart-Delay=20" >> $launcher

# Tip: autostart with X-GNOME-.. not works, not specified in the desktop specification.

chmod +x $launcher
