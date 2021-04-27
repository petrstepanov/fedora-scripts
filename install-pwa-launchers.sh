#!/bin/bash


echo $HOME

echo "Installing chromium (run with chromium-browser)..."
sudo dnf install -y chromium

# why use Chromium for SondCloud?
# because SoundCloud plugin available for Chromium

# Apply dark theme (">" - write, ">>" - append)
mkdir -p ~/.config-dark/gtk-3.0
echo "[Settings]" > ~/.config-dark/gtk-3.0/settings.ini
echo "gtk-application-prefer-dark-theme=true" >> ~/.config-dark/gtk-3.0/settings.ini
echo "gtk-theme-name=Adwaita:dark" >> ~/.config-dark/gtk-3.0/settings.ini

# Make alias dark Chromium
echo "Making dark chromium alias (run with chromium-browser-dark)..."
sed -i "/#alias-chromium-browser-dark/d" ~/.bashrc
echo "alias chromium-browser-dark='env XDG_CONFIG_HOME=$HOME/.config-dark `which chromium-browser`' #alias-chromium-browser-dark" >> ~/.bashrc
source ~/.bashrc
# Hint: now you can run dark Chromium in terminal with regular 'chromium-browser-dark' command

# Make Chromium launcher with custom icon (needs to install the extensions in PWAs)
DESKTOP_FILE="chromium-browser.desktop"
DESKTOP_FILE_DARK="chromium-browser.desktop"
cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE_DARK
sed -i "s;Icon=chromium-browser;Icon=gnome-chromium;" ~/.local/share/applications/$DESKTOP_FILE_DARK

# Make Dark Chromium launcher (needs to install the extensions in PWAs)
DESKTOP_FILE="chromium-browser.desktop"
DESKTOP_FILE_DARK="chromium-browser-dark.desktop"
cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE_DARK

# using double quotes in sed will tell shell to substitute environment variables
# https://askubuntu.com/questions/76808/how-do-i-use-variables-in-a-sed-command
# sed allows usinf any character as a separator (trying ;)
# https://unix.stackexchange.com/questions/379572/escaping-both-forward-slash-and-back-slash-with-sed
sed -i "s;Chromium Web Browser;Chromium Web Browser (Dark);" ~/.local/share/applications/$DESKTOP_FILE_DARK
sed -i "s;Icon=chromium-browser;Icon=gnome-chromium-dark;" ~/.local/share/applications/$DESKTOP_FILE_DARK
sed -i "s;Exec=;Exec=env XDG_CONFIG_HOME=$HOME/.config-dark ;" ~/.local/share/applications/$DESKTOP_FILE_DARK

echo "Installing launchers..."
xdg-desktop-menu install ./pwa-launchers/*

# add user's home folder path to installed launchers
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-soundcloud-dark.desktop
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-figma-dark.desktop
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-snipcart-dark.desktop
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-zoho-dark.desktop

# Explicitly set --user-data-dir=~/.config/chromium for Chromium
# DESKTOP_FILE="chromium-browser.desktop"
# cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE
# sed -i "s;/usr/bin/chromium-browser;/usr/bin/chromium-browser --user-data-dir=$HOME/.config/chromium/Default;" ~/.local/share/applications/$DESKTOP_FILE

# Key: do not mess with switching profiles. Chrome remembers Profiles and that's a pain. Use always "--profile-directory=Default" but change "--user-data-dir=/tmp/zoho2"

xdg-desktop-menu forceupdate

echo "Next steps - open 'chromium-browser-dark'"
echo "1. Install SoundCloud extension https://addoncrop.com/soundcloud-music-downloader/"
echo "   Extract, open Chrome extensions, turn on Developer Mode, load unpacked."
echo "2. Install Tapermnkey extension for Snipcart"
echo "..."

echo "Done."

