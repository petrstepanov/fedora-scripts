#/bin/bash

# Stop if running
if command -v p3x-ramdisk &> /dev/null
then
    echo "p3x-ramdisk found. Stopping"
    sudo p3x-ramdisk start $USER
fi

# How-to: install-ramdisk.sh 2048

# Install RAMDisk
sudo dnf -y install npm
sudo npm install -g p3x-ramdisk --unsafe-perm=true --allow-root

# Obtain RAMDisk size from parameter
SIZE=${1:-3072}

# Make RAMDisk directories hidden because I only use persistent
RAMDISK_DIR=.ramdisk
RAMDISK_PERSISTENT_DIR=.ramdisk-persistent

# Generate service and script files
sudo p3x-ramdisk install petrstepanov -s ${SIZE} -r ${RAMDISK_DIR} -p ${RAMDISK_PERSISTENT_DIR}

# Specify partition in fstab
# Delete line containing "RAMDisk" from fstab (if exists)
sudo sed -i "/RAMDisk/d" /etc/fstab
# Add RAMDisk to fstab
echo "tmpfs   ${HOME}/${RAMDISK_DIR} tmpfs   gid=10000,uid=10000,size=${SIZE}M   0 0" | sudo tee -a /etc/fstab

# Mount RAMDisk
sudo mount -a

# Check everything is ok
df -h

# Replace home paths with bin paths in .service files
sed -i "s;${HOME}/.p3x-ramdisk/;;" ~/.p3x-ramdisk/*.service
sudo cp ${HOME}/.p3x-ramdisk/p3x-ramdisk.sh /usr/bin/

# Remove the RAMDisk script in home folder just in case
# rm ${HOME}/.p3x-ramdisk/p3x-ramdisk.sh

sudo p3x-ramdisk start $USER

# Create symboilc link to persistent RAMDisk in $HOME
rm $HOME/RAMDisk
ln -s $HOME/${RAMDISK_DIR}/.p3x-ramdisk-persistence/content $HOME/RAMDisk
