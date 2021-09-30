#/bin/bash

# Update the system
sudo dnf upgrade

# Install keyboard repmap
cd ~/Downloads
git clone https://github.com/petrstepanov/gnome-macos-remap
cd gnome-macos-remap
chmod +x install.sh
sh install.sh

# Add minimize and maximize window buttons
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'



# Install Dash to Dock
cd ~/Downloads
git clone https://github.com/ewlsh/dash-to-dock
cd dash-to-dock
make
make install
