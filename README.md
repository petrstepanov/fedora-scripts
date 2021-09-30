# Fedora Scripts
Set of useful scripts for Fedora linux. These are rather custom scripts that tailor GNOME to my personal needs. Feel free to reuse some of the scripts.

## Clean Install Setup

First off, after a fresh install of Fedora a system upgrage is needed. Upgrade is followed by the install a keyboard remap that will simulate majority of the macOS keybindings on GNOME platform. Do not get me wrong. I respect GNOME. But I hate having different shortcuts and switch back and forth all the time. These changes will require a system restart.
```
# Enable RPM Fusion repos
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Upgrade the system
sudo dnf -y upgrade

# Install keyboard repmap
sudo dnf -y install autokey autokey-gtk
cd ~/Downloads
git clone https://github.com/petrstepanov/gnome-macos-remap
cd gnome-macos-remap
chmod +x install.sh
sh install.sh

# Enable User extensions
gsettings set org.gnome.shell.disable-user-extensions false

# Install Dash to Dock extension (recent ewlsh build)
sudo dnf -y install sassc
cd ~/Downloads
git clone -b ewlsh/gnome-40 https://github.com/ewlsh/dash-to-dock
cd dash-to-dock
make
make install
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions disable background-logo@fedorahosted.org
sudo dnf install gnome-extensions-app

# Restart
sudo reboot

# Minor stuff
sudo dnf -y install gnome-extension-app


```
At the login screen select **GNOME on Xorg**. This will not only allow AutoKey to wrk properly, but also will let you to forward the X11 over the SSH which is a must have feature when working with remote computers. Open AutoKey, In Edit -> Preferences menu make sure the ☑️ **Automatically start AutoKey at login** checkbox is on.

Next, we install the Dash to Dock and application launcher:
```
# Turn GNOME extensions on/off
gnome-extensions enable dash-to-dock
gnome-extensions disable background-logo@fedorahosted.org

# Add minimize and maximize window buttons
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
```
