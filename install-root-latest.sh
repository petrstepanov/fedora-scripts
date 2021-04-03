#!/bin/bash

# Download the ROOT releases page and match the recent ROOT version
# https://stackoverflow.com/questions/1891797/capturing-groups-from-a-grep-regex

string=`wget https://root.cern/install/all_releases/ -q -O -`
regex="[0-9]+\.[0-9]+\/[0-9]+"

if [[ $string =~ $regex ]] 
then
	# Get ROOT version from the match group
	v="${BASH_REMATCH[0]}"
	
	# Replace / with . in version number
	v=`echo "$v" | sed 's/\//\./'`
	echo "$v"

	# Install ROOT dependencies
	sudo dnf -y groupinstall "Development Tools" "Development Libraries" 
	sudo dnf -y install git cmake3 gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python-devel openssl-devel
	sudo dnf -y install libuuid-devel redhat-lsb-core gcc-gfortran pcre-devel mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel fftw-devel cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel openldap-devel python-devel python3-numpy libxml2-devel gsl-devel R-devel R-Rcpp-devel R-RInside-devel

	# Download ROOT (-O overwrite existing file)
	cd ~/Downloads
	wget -O root_v$v.source.tar.gz https://root.cern/download/root_v$v.source.tar.gz

	# Unpack ROOT archive
	mkdir -p ~/Source && cd ~/Source
	tar -xvf ~/Downloads/root_v$v.source.tar.gz

	# Create install and build directories
	rm -rf ~/Applications/root-$v && mkdir -p ~/Applications/root-$v
	rm -rf ~/Source/root-$v-build && mkdir -p ~/Source/root-$v-build && cd ~/Source/root-$v-build

	# Unset environment libraries (if previously installed ROOT)
	# https://root-forum.cern.ch/t/cannot-compile-root-v6-22-08-with-debug-symbols-and-all-options/44242
	unset ROOTSYS
	unset LD_LIBRARY_PATH

	# Compile ROOT
	cmake -Dall=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=~/Applications/root-$v ~/Source/root-$v
	cmake --build . --target install -- -j$(nproc)

	# Source ROOT
	cd ~/Applications/root-$v
	echo source `find $(pwd) -name "thisroot.sh"` >> ~/.bashrc
	source ~/.bashrc	

else
	echo Cannot determine the recent ROOT version
fi
