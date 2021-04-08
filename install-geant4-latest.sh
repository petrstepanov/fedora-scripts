#!/bin/bash

# Download the Geant4 releases page and match the recent Geant4 version
# https://stackoverflow.com/questions/1891797/capturing-groups-from-a-grep-regex
# https://unix.stackexchange.com/questions/251013/bash-regex-capture-group

string=`wget https://geant4.web.cern.ch/support/download -q -O -`
regex="geant([0-9\.a-z]+).tar.gz"

if [[ $string =~ $regex ]] 
then
	# Get Geant4 filename from regex match
	filename="${BASH_REMATCH[0]}"
	
	# Build downlioad URL
	url="http://cern.ch/geant4-data/releases/$filename"
	echo "Download URL: $url"
	
	# Get Geant4 version from the match group
	v=${BASH_REMATCH[1]}
	echo "Geant version: $v"
	
	# Install Geant4 dependencies
	sudo dnf -y groupinstall "Development Tools" "Development Libraries" 
	sudo dnf -y install mesa-libGL-devel qt5* libX11* libXmu* motif* expat-devel

	# Download Geant4 (-O overwrite existing file)
	cd ~/Downloads
	wget -O $filename $url

	# Unpack Geant4 archive
	mkdir -p ~/Source && cd ~/Source
	tar -xvf ~/Downloads/$filename

	# Create install and build directories
	rm -rf ~/Applications/geant$v && mkdir -p ~/Applications/geant$v
	rm -rf ~/Source/geant$v-build && mkdir -p ~/Source/geant$v-build && cd ~/Source/geant$v-build

	# Unset environment libraries (if previously installed Geant)
#	unset ROOTSYS
#	unset LD_LIBRARY_PATH

	# Compile Geant4
	cmake -DCMAKE_INSTALL_PREFIX=~/Applications/geant$v/ ~/Source/geant$v
	cmake -DGEANT4_INSTALL_DATA=ON .
	cmake -DGEANT4_USE_OPENGL_X11=ON .
	cmake -DGEANT4_USE_QT=ON .
	cmake -DGEANT4_USE_XM=ON .
	cmake -DGEANT4_BUILD_MULTITHREADED=ON .
	cmake -DCMAKE_BUILD_TYPE=Debug .

	# make
	make -j$(nproc)
	make install
	
	# Source Geant4
	cd ~/Applications/geant$v
	sed -i "/#source-geant4/d" ~/.bashrc		
	echo source `find $(pwd) -name "geant4.sh" #source-geant4` >> ~/.bashrc
	source ~/.bashrc	
else
	echo Cannot determine the recent Geant version
fi
