#!/bin/bash


echo $HOME

echo "Installing chromium (run with chromium-browser)..."
sudo dnf install -y chromium

# why use chromium for SondCloud?
# because Soundcloud plugin available for chromium

# Apply dark theme
echo "Installing dark theme (run with chromium-browser-dark)..."

rm -rf ~/.config/chromium-dark/
mkdir -p ~/.config/chromium-dark/gtk-3.0
printf '%s\n%s\n' '[Settings]' 'gtk-application-prefer-dark-theme=true' > ~/.config/chromium-dark/gtk-3.0/settings.ini

# Make alias for simplenote command. In ~/.bashrc add line:
echo "alias chromium-browser-dark='env XDG_CONFIG_HOME=$HOME/.config/chromium-dark `which chromium-browser`'" >> ~/.bashrc
source ~/.bashrc
# Hint: now you can run dark Chromium in terminal with regular 'chromium-browser-dark' command

# Make Chromium launcher (do not need)
cp /usr/share/applications/chromium-browser.desktop ~/.local/share/applications/chromium-browser-dark.desktop

# using double quotes in sed will tell shell to substitute environment variables
# https://askubuntu.com/questions/76808/how-do-i-use-variables-in-a-sed-command
# sed allows usinf any character as a separator (trying ;)
# https://unix.stackexchange.com/questions/379572/escaping-both-forward-slash-and-back-slash-with-sed
sed -i "s;Chromium Web Browser;Chromium Web Browser (Dark);" ~/.local/share/applications/chromium-browser-dark.desktop
sed -i "s;Exec=/usr/bin/chromium-browser %U;Exec=env XDG_CONFIG_HOME=$HOME/.config/chromium-dark /usr/bin/chromium-browser %U;" ~/.local/share/applications/chromium-browser-dark.desktop

echo "Installing launchers..."
xdg-desktop-menu install ./pwa-launchers/*

# fix path in the installed launcher
sed -i "s;XDG_CONFIG_HOME=;XDG_CONFIG_HOME=$HOME;" ~/.local/share/applications/chrome-soundcloud-dark.desktop

echo "now open 'chromium-browser-dark'"
echo "install SoundCloud extension https://addoncrop.com/soundcloud-music-downloader/"
echo "extract, open Chrome extensions, turn on Developer Mode, load unpacked."

echo "Done."

