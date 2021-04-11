#!/bin/bash

# Open file picker and select the desktop launcher filename to be modified
FILE=`zenity --file-selection --title="Select application launcher you want to make dark" --filename=/usr/share/applications/`
case $? in
	0)
		echo "File \"$FILE\" selected." ;;
	1)
		echo "No desktop launcher selected." && exit 1 ;;
	-1)
		echo "An unexpected error has occurred." && exit 1 ;;
esac

# Read desktop launcher contents
STRING=`cat $FILE`
# echo "$STRING"

# Extract command from launcher 
# https://askubuntu.com/questions/5172/running-a-desktop-file-in-the-terminal
COMMAND=`grep '^Exec' $FILE | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g'`
# echo "Command: $COMMAND"

# Do basename to remove possible "env VAR1=..." in front of the command
COMMAND_PREFIX=`echo $COMMAND | grep -Po "env +([A-Z_]+=[a-zA-Z0-1]+ +)+"`
# echo "Command prefix: $COMMAND_PREFIX"
		
COMMAND=`echo $COMMAND | sed "s;$COMMAND_PREFIX;;g"`		
# echo "Command after prefix removal: $COMMAND"

# Get rid of suffixes like "--hide-window", "%U" etc by grab only first word in command
COMMAND=`echo $COMMAND | head -n1 | awk '{print $1;}'`
# echo "Command: $COMMAND"

# Finally we take the basename and obtain the actiual executable command
EXECUTABLE=`basename $COMMAND`
echo "Executable: $EXECUTABLE"

# Exit if executable is undetermined 
if [ -z "${EXECUTABLE}" ]
then
	exit 1
fi

# Create ~/.config-dark/ for apps with dark decoration
mkdir -p ~/.config-dark/gtk-3.0
echo "[Settings]" > ~/.config-dark/gtk-3.0/settings.ini
echo "gtk-application-prefer-dark-theme=true" >> ~/.config-dark/gtk-3.0/settings.ini

# Remove alias from .bashrc (if exists)
sed -i "/#alias-$EXECUTABLE/d" ~/.bashrc

# Add alias to bashrc
echo "alias $EXECUTABLE='env XDG_CONFIG_HOME=$HOME/.config-dark `which $EXECUTABLE`' #alias-$EXECUTABLE" >> ~/.bashrc
source ~/.bashrc

# Override application launcher
FILENAME=`basename $FILE`
cp $FILE ~/.local/share/applications/$FILENAME
sed -i "s;Exec=;Exec=env XDG_CONFIG_HOME=$HOME/.config-dark ;" ~/.local/share/applications/$FILENAME
xdg-desktop-menu forceupdate

echo "Install completed!"

