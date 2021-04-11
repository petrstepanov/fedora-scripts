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
echo "$STRING"
# Extract executable command
# Bash regex is hard to test. It does not support non-matching groups and hard to test.
# sed does not support perl-compatible regex.
# Therefore we are using `grep -P` here
# grep -Po always outputs non-capturing groups. Damn.

# Making it very basic way then 'Exec=env ABC=DEF /command/to/file' will not be supported for now
COMMAND=`echo "$STRING" | grep -Po -m 1 '(?<=Exec=)([A-Za-z0-9\/\._-]+)'`
echo "Command: $COMMAND"
EXECUTABLE=`basename $COMMAND`
echo "Executable: $EXECUTABLE"

# Exit if executable is undetermined 
if [ -z "${EXECUTABLE}" ]
then
	exit 1
fi

# Unset alias and remove it from .bashrc (if exists)
unalias $EXECUTABLE		
sed -i "/#alias-$EXECUTABLE/d" ~/.bashrc
source ~/.bashrc		

# Override application launcher
FILENAME=`basename $FILE`
rm -rf ~/.local/share/applications/$FILENAME
xdg-desktop-menu forceupdate

echo "Uninstall completed!"

