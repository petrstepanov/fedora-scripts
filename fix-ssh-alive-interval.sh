#!/bin/bash

# Prevent "client_loop: send disconnect: Broken pipe" ssh termination
# Keep connection alive with up to 100 seconds of idle time
# https://serverfault.com/questions/253313/ssh-returns-bad-owner-or-permissions-on-ssh-config

CONFIG=~/.ssh/config

touch $CONFIG
echo "Host *" >> $CONFIG
echo "   ServerAliveInterval 100" >> $CONFIG
echo "   ServerAliveCountMax 10" >> $CONFIG
#echo "   TCPKeepAlive no" >> $CONFIG

# Set user permissions for SSH configuration file
# https://serverfault.com/questions/253313/ssh-returns-bad-owner-or-permissions-on-ssh-config

chmod 600 ~/.ssh/config
chown $USER $CONFIG
