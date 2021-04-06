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
echo "alias chromium-browser-dark='env XDG_CONFIG_HOME=$HOME/.config-dark `which chromium-browser`'" >> ~/.bashrc
source ~/.bashrc
# Hint: now you can run dark Chromium in terminal with regular 'chromium-browser-dark' command

# Make Dark Chromium launcher (needs to install the extensions in PWAs)
DESKTOP_FILE="chromium-browser.desktop"
cp /usr/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE

# using double quotes in sed will tell shell to substitute environment variables
# https://askubuntu.com/questions/76808/how-do-i-use-variables-in-a-sed-command
# sed allows usinf any character as a separator (trying ;)
# https://unix.stackexchange.com/questions/379572/escaping-both-forward-slash-and-back-slash-with-sed
sed -i "s;Chromium Web Browser;Chromium Web Browser (Dark);" ~/.local/share/applications/$DESKTOP_FILE
sed -i "s;Exec=;Exec=env XDG_CONFIG_HOME=$HOME/.config-dark ;" ~/.local/share/applications/$DESKTOP_FILE ~/.local/share/applications/$DESKTOP_FILE

echo "Installing launchers..."
xdg-desktop-menu install ./pwa-launchers/*

# fix path in the installed launcher
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-soundcloud-dark.desktop

echo "now open 'chromium-browser-dark'"
echo "install SoundCloud extension https://addoncrop.com/soundcloud-music-downloader/"
echo "extract, open Chrome extensions, turn on Developer Mode, load unpacked."

echo "Done."
