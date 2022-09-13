#!/bin/bash

sudo sed -i "s;HandleLidSwitch=suspend;HandleLidSwitch=ignore;" /etc/systemd/logind.conf
sudo sed -i "s;HandleLidSwitchExternalPower=suspend;HandleLidSwitchExternalPower=ignore;" /etc/systemd/logind.conf
