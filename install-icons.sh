#!/bin/bash

cd ~/Downloads
rm -rf ./gnome-third-party-icons
git clone https://github.com/petrstepanov/gnome-third-party-icons && cd gnome-third-party-icons
chmod +x ./install.sh
sh ./install.sh
