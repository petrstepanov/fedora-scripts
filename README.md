Fedora Scripts
==============
Set of useful scripts for Fedora linux. These are rather custom scripts that tailor GNOME to my personal needs. Feel free to reuse some of the scripts.


Clean Install Setup
-------------------

First off, after a fresh install of Fedora a system upgrage is needed. Upgrade is followed by the install a keyboard remap that will simulate majority of the macOS keybindings on GNOME platform. Do not get me wrong. I respect GNOME. But I hate having different shortcuts and switch back and forth all the time. These changes will require a system restart.

Setup Git
```
git config --global user.name "Petr Stepanov"
git config --global user.email stepanovps@gmail.com
git config --global core.editor nano
```

Enable RPM Fusion repos
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Enable Flatpak repository
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Upgrade the system
```
sudo dnf -y upgrade
```

Install Broadcom Wi-Fi Driver (on certain MacBooks)
```
sudo dnf install -y broadcom-wl
```

Install Development Tools
```
sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install cmake
```

Install ROOT (Release Version)
```
sudo dnf install root root-* liburing*
```

Replace new GNOME text editor with nano
```
sudo dnf remove -y gnome-text-editor && sudo dnf install -y gedit
```

Install MacOS keyboard repmap
```
sudo dnf -y install autokey autokey-gtk
mkdir ~/Development && cd ~/Development
git clone https://github.com/petrstepanov/gnome-macos-remap
cd gnome-macos-remap
chmod +x install.sh
sh install.sh
sudo reboot
```

At the login screen select **GNOME on Xorg**. Open AutoKey, In Edit -> Preferences menu make sure the ☑️ **Automatically start AutoKey at login** checkbox is on. Tip: to start AutoKey in debug mode, run in Terminal:
```
sed -i "s;Exec=autokey-gtk;Exec=autokey-gtk -l;" /home/petrstepanov/.config/autostart/autokey.desktop
sed -i "s;Terminal=false;Terminal=true;" /home/petrstepanov/.config/autostart/autokey.desktop
```

Rename `Documents` into `Development` folder in Nautilus run:
```
sed -i "s;$HOME/Development;$HOME/Documents;" /home/petrstepanov/.config/user-dirs.dirs
```

GNOME extensions. We install the Caffeine and others:
```
# Enable User extensions
gsettings set org.gnome.shell.disable-user-extensions false

# Disable background logo extension
gnome-extensions disable background-logo@fedorahosted.org

# Install other useful extensions in GUI mode
sudo dnf install gnome-extensions-app

# Dash to Panel: https://extensions.gnome.org/extension/1160/dash-to-panel/
# Caffeine: https://extensions.gnome.org/extension/517/caffeine/
# Easy Screencast: https://extensions.gnome.org/extension/690/easyscreencast/
```

Few GNOME appearance tweaks along with ULauncher app installation:
```
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gtk.settings.file-chooser sort-directories-first true
```

Install ULauncher
```
sudo dnf install ulauncher
```

Below we will install useful applications for everyday use:

Visual Studio Code:
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install code
```

Microsoft Teams:
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[teams]\nname=teams\nbaseurl=https://packages.microsoft.com/yumrepos/ms-teams\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/teams.repo'
sudo dnf install teams
```

Other stuff:
```
sudo dnf -y install gitg gnome-search-tool gthumb mediawriter meld menulibre \
                    texlive-scheme-full texmaker xpad foliate htop neofetch cpu-x \
                    dconf-editor
```

If running on MacBook Air 2013+ fix webcam
```
sh ./install-facetime-hd-webcam.sh
```

Make launchers for a few PWAs that I use
```
sh ./install-icons
sh ./install-pwa-launchers.sh
```

Do not show "Chrome did not shut down correctly" error
```
sh ./install-chrome-crash-fix.sh
```

Install RAMDisk
```
sh ./install-ramdisk.sh
```

Install VirtualBox
```
cd ~/Downloads
wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import oracle_vbox.asc
wget https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo cp ./virtualbox.repo /etc/yum.repos.d/
sudo dnf -y install VirtualBox-6*
```

Next steps are done by hand:
* Setup Mailspring accounts and signatures.
* Add Nextcloud and import calendars.<br/>https://www.officeholidays.com/ics-fed/usa<br/>https://indico.bnl.gov/export/categ/343.ics?from=       -31d<br/>https://indico.bnl.gov/export/categ/344.ics?from=-31d</br>https://indico.bnl.gov/export/categ/345.ics?from=-31d</br>https://indico.bnl.gov/export/categ/346.ics?from=-31d</br>https://indico.bnl.gov/export/categ/347.ics?from=-31d</br>https://indico.bnl.gov/export/categ/218.ics?from=-31d
* Install Yandex.Disk. [Download here](https://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm). Run `yandex-disk setup`.
* Install `synth-shell` for [better reading the Terminal](https://github.com/andresgongora/synth-shell) output.

Enable Guestures on X11
```
sudo dnf install touchegg
sudo systemctl enable touchegg
```

Next, install this extension: https://github.com/JoseExposito/touchegg#ubuntu-debian-and-derivatives

Install LaTeX
```
sudo dnf install latex-scheme-full texmaker
```

Install a few fonts
```
sudo dnf install -y google-robo* sudo dnf install texlive-cm-unicode
```
