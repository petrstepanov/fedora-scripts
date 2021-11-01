#/bin/bash

echo "Fixing Nautilus files folders in a loop"
while :
do
	echo "Press CTRL+C to exit"
	gsettings set org.gtk.settings.file-chooser sort-directories-first true
	sleep 10
done
