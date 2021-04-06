#!/bin/bash

# Download the Simplenote releases page
string=`wget https://github.com/Automattic/simplenote-electron/releases/latest -q -O -`
regex="Simplenote-linux-([0-9\.]+)-x86_64.rpm"

cd ~/Downloads

if [[ $string =~ $regex ]] 
then
	# Get Simplenote filename from regex match
	filename="${BASH_REMATCH[0]}"
		
	# Get Simplenote version from the match group
	v=${BASH_REMATCH[1]}
	echo "Simplenote version: $v"
	
	# Build download URL
	url="https://github.com/Automattic/simplenote-electron/releases/download/v$v/$filename"
	echo "Download URL: $url"

	# Download Simplenote (-O overwrite existing file)
	cd ~/Downloads
	wget -O $filename $url

	# Uninstall previous version and install new one
	echo "Uninstalling old version..."
	sudo rpm -e --allmatches simplenote

	echo "Installing new version..."
	sudo rpm -i $filename
	
	# Apply dark theme (">" - write, ">>" - append)
	mkdir -p ~/.config-dark/gtk-3.0
	echo "[Settings]" > ~/.config-dark/gtk-3.0/settings.ini
	echo "gtk-application-prefer-dark-theme=true" >> ~/.config-dark/gtk-3.0/settings.ini
	echo "gtk-theme-name=Adwaita:dark" >> ~/.config-dark/gtk-3.0/settings.ini
	
	# Make alias for simplenote command. In ~/.bashrc add line:
	APP="simplenote"
	echo "alias $APP='env XDG_CONFIG_HOME=$HOME/.config-dark `which $APP`'" >> ~/.bashrc
	source ~/.bashrc
	# Hint: now you can run dark app in terminal with regular '<app-name>' command
	
	# Override application launcher
	DESKTOP_FILE="simplenote.desktop"
	cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE
	sed -i "s;Exec=;Exec=env XDG_CONFIG_HOME=$HOME/.config-dark ;" ~/.local/share/applications/$DESKTOP_FILE
	# Hint: now the default launcher will launch app in dark mode
else
	echo Cannot determine the recent Simplenote version
fi
