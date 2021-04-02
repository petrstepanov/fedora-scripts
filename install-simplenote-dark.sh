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

	# Install
	rpm -i $filename
	
	# Apply dark theme
	mkdir -p ~/.config/Simplenote/gtk-3.0
	printf '%s\n%s\n' '[Settings]' 'gtk-application-prefer-dark-theme=true' > ~/.config/Simplenote/gtk-3.0/settings.ini
	
	# Make alias for simplenote command. In ~/.bashrc add line:
	echo 'alias simplenote="env XDG_CONFIG_HOME=$HOME/.config/Simplenote `which simplenote`"' >> ~/.bashrc
	source ~/.bashrc
	# Hint: now you can run dark Simplenote in terminal with regular 'simplenote' command
	
	# Override Simplenote launcher
	cp /usr/share/applications/simplenote.desktop ~/.local/share/applications/simplenote.desktop
	sed -i 's/Exec=\/opt\/Simplenote\/simplenote %U/Exec=env XDG_CONFIG_HOME=.config\/Simplenote \/opt\/Simplenote\/simplenote %U/' ~/.local/share/applications/simplenote.desktop
	# Hint: now the default launcher will launch Simplenote in dark mode
else
	echo Cannot determine the recent Simplenote version
fi
