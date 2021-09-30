# Fedora Scripts
Set of useful scripts for Fedora linux. These are rather custom scripts that tailor GNOME to my personal needs. Feel free to reuse some of the scripts.

## Clean Install Setup

First off, after a fresh install of Fedora a system upgrage is needed. Upgrade is followed by the install a keyboard remap that will simulate majority of the macOS keybindings on GNOME platform. Do not get me wrong. I respect GNOME. But I hate having different shortcuts and switch back and forth all the time. These changes will require a system restart.
```
# Upgrade the system
sudo dnf -y upgrade

# Install keyboard repmap
sudo dnf -y install autokey autokey-gtk
cd ~/Downloads
git clone https://github.com/petrstepanov/gnome-macos-remap
cd gnome-macos-remap
chmod +x install.sh
sh install.sh
cp /usr/share/applications/autokey-gtk.desktop ~/.config/autostart/

# Restart
sudo reboot
```
At the login screen select **GNOME on Xorg**. This will not only allow AutoKey to wrk properly, but also will let you to forward the X11 over the SSH which is a must have feature when working with remote computers. 
