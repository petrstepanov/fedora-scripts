#/bin/bash

sudo dnf -y install npm
sudo npm install -g p3x-ramdisk --unsafe-perm=true --allow-root
sudo p3x-ramdisk install $USER -s 2048
echo "tmpfs   /home/$USER/ramdisk tmpfs   gid=10000,uid=10000,size=2048M   0 0" | sudo tee -a /etc/fstab
sudo mount -a
df -h
sudo p3x-ramdisk start $USER
