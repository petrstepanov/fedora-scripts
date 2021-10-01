#!/bin/bash

function copySources () {
	# $1 - source folder
	# $2 - destination folder
	find $1 -type f | grep -i '\.c$\|\.cpp$\|\.cxx$\|\.cc$' | xargs -i cp {} $2
}

# Identify ROOT and Geant4 installations
rootDir=`ls -1 ~/Source | grep "root.*[0-9]$" | tail -1`
rootSourcePath=~/Source/$rootDir/

geantDir=`ls -1 ~/Source | grep "geant4.*[0-9]$" | tail -1`
geantSourcePath=~/Source/$geantDir/source/

# Identify the destination directories
rootDestPath=~/Source/root-sources/
geantDestPath=~/Source/geant4-sources/
if [ -d ~/ramdisk-persistent/current ] 
then
    echo "Found RAMDISK install." 
    rootDestPath=~/ramdisk-persistent/current/root-sources/
    geantDestPath=~/ramdisk-persistent/current/geant4-sources/
fi

# Copy ROOT sources
if [ ! -z "$rootDir" ]
then
    echo "Found ROOT source directory: $rootSourcePath"
    rm -rf $rootDestPath && mkdir $rootDestPath
    copySources $rootSourcePath $rootDestPath
    cd $rootDestPath
    chmod -w ./*
fi

# Copy Geant4 sources
if [ ! -z "$geantDir" ]
then
    echo "Found Geant4 source directory: $geantSourcePath"
    rm -rf $geantDestPath && mkdir $geantDestPath
    copySources $geantSourcePath $geantDestPath
    cd $geantDestPath
    chmod -w ./*
fi

echo
