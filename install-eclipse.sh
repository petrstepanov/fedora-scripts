#/bin/bash

sudo dnf -y install eclipse

# Increase Eclipse heap 
sudo cp /usr/lib/eclipse/eclipse.ini /usr/lib/eclipse/eclipse.ini.bak
sudo sed -i "s;-Xms512m;-Xms1024m;" /usr/lib/eclipse/eclipse.ini
sudo sed -i "s;-Xmx1024m;-Xmx4096m;" /usr/lib/eclipse/eclipse.ini
