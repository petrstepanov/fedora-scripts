#!/bin/bash

# Install Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

# Apply dark theme
mkdir -p ~/.config/Code/gtk-3.0
printf '%s\n%s\n' '[Settings]' 'gtk-application-prefer-dark-theme=true' > ~/.config/Code/gtk-3.0/settings.ini

# Make alias for simplenote command. In ~/.bashrc add line:
echo 'alias code="env XDG_CONFIG_HOME=$HOME/.config/Code `which code`"' >> ~/.bashrc
source ~/.bashrc
# Hint: now you can run dark Code in terminal with regular 'code' command

# Override Code launcher
cp /usr/share/applications/code.desktop ~/.local/share/applications/code.desktop
sed -i 's/Exec=\/usr\/share\/code\/code --no-sandbox --unity-launch %F/Exec=env XDG_CONFIG_HOME=.config\/Code \/usr\/bin\/code --no-sandbox --unity-launch %F/' ~/.local/share/applications/code.desktop
# Hint: now the default launcher will launch Simplenote in dark mode

