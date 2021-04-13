#!/bin/bash

sudo dnf install gtkglext-devel
sudo dnf --releasever=32 install pangox-compat

sudo rm -f /etc/yum.repos.d/AnyDesk-Fedora.repo
sudo tee -a /etc/yum.repos.d/AnyDesk-Fedora.repo > /dev/null <<EOT
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/\$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOT

sudo dnf install anydesk
