# Fedora Scripts
Set of useful scripts for Fedora linux. These are rather custom scripts that tailor GNOME to my personal needs. Feel free to reuse some of the scripts.

## Clean Install Setup

First off, after a fresh install of Fedora a system upgrage is needed. Upgrade is followed by the install a keyboard remap that will simulate majority of the macOS keybindings on GNOME platform. Do not get me wrong. I respect GNOME. But I hate having different shortcuts and switch back and forth all the time. These changes will require a system restart.
```
# Enable RPM Fusion repos
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Upgrade the system
sudo dnf -y upgrade

# Install keyboard repmap
sudo dnf -y install autokey autokey-gtk
cd ~/Downloads
git clone https://github.com/petrstepanov/gnome-macos-remap
cd gnome-macos-remap
chmod +x install.sh
sh install.sh

# Restart
sudo reboot
```

At the login screen select **GNOME on Xorg**. This will not only allow AutoKey to wrk properly, but also will let you to forward the X11 over the SSH which is a must have feature when working with remote computers. Open AutoKey, In Edit -> Preferences menu make sure the ☑️ **Automatically start AutoKey at login** checkbox is on.

Next, we will work on the GNOME extensions. We install the Dash to Dock, Caffeine and others:
```
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

# Disable background logo extension
gnome-extensions disable background-logo@fedorahosted.org

# Install other useful extensions in GUI mode
sudo dnf install gnome-extensions-app
# Caffeine: https://extensions.gnome.org/extension/517/caffeine/
# No overview at startup: https://extensions.gnome.org/extension/4099/no-overview/
```
Few GNOME appearance tweaks along with ULauncher app installation:
```
# Tweak GNOME appearance
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gtk.settings.file-chooser sort-directories-first true

# Install ULauncher
sudo dnf install ulauncher
```
Below we will install useful applications for everyday use
```
sudo dnf -y install gitg menulibre meld gnome-search-tool gthumb mediawriter 

# Install Eclipse IDE
sh ./install-eclipse.sh

```
Next steps are done by hand:
* Setup Mailspring accounts and signatures.
* Add Nextcloud and import calendars.<br/>https://indico.bnl.gov/export/categ/343.ics?from=-31d<br/>https://indico.bnl.gov/export/categ/344.ics?from=-31d</br>https://indico.bnl.gov/export/categ/345.ics?from=-31d</br>https://indico.bnl.gov/export/categ/346.ics?from=-31d</br>https://indico.bnl.gov/export/categ/347.ics?from=-31d</br>https://indico.bnl.gov/export/categ/218.ics?from=-31d
* Install Yandex.Disk. [Download here](https://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm). Run `yandex-disk setup`.
