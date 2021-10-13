#/bin/bash

sed -i "s;\"exit_type\":\"Crashed\";\"exit_type\":\"Normal\";" ~/.config/chromium/Default/Preferences
sed -i "s;\"exit_type\":\"Crashed\";\"exit_type\":\"Normal\";" ~/.config-dark/chromium/Default/Preferences
