#!/bin/bash

sudo sed -i "s;HandleLidSwitch=suspend;HandleLidSwitch=ignore;" /etc/systemd/logind.conf
sudo sed -i "s;#HandleLidSwitch=;HandleLidSwitch=;" /etc/systemd/logind.conf

sudo sed -i "s;HandleLidSwitchExternalPower=suspend;HandleLidSwitchExternalPower=ignore;" /etc/systemd/logind.conf
sudo sed -i "s;#HandleLidSwitchExternalPower=;HandleLidSwitchExternalPower=;" /etc/systemd/logind.conf
