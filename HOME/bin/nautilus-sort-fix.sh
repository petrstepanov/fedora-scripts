#/bin/bash

echo "Fixing Nautilus files folders in a loop"
while :
do
	echo "Press CTRL+C to exit"
	gsettings set org.gtk.Settings.FileChooser sort-directories-first true
	gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
	sleep 10
done
