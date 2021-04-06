#!/bin/bash

# Install Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

# Apply dark theme (">" - write, ">>" - append)
mkdir -p ~/.config-dark/gtk-3.0
echo "[Settings]" > ~/.config-dark/gtk-3.0/settings.ini
echo "gtk-application-prefer-dark-theme=true" >> ~/.config-dark/gtk-3.0/settings.ini
echo "gtk-theme-name=Adwaita:dark" >> ~/.config-dark/gtk-3.0/settings.ini

# Make alias for simplenote command. In ~/.bashrc add line:
APP="code"
echo "alias $APP='env XDG_CONFIG_HOME=$HOME/.config-dark `which $APP`'" >> ~/.bashrc
source ~/.bashrc
# Hint: now you can run dark app in terminal with regular '<app-name>' command

# Override application launcher
DESKTOP_FILE="code.desktop"
cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE
sed -i "s;Exec=;Exec=env XDG_CONFIG_HOME=$HOME/.config-dark ;" ~/.local/share/applications/$DESKTOP_FILE
# Hint: now the default launcher will launch app in dark mode
