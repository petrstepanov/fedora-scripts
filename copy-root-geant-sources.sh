#!/bin/bash

function copySources () {
	# $1 - source folder
	# $2 - destination folder
	find $1 -type f | grep -i '\.c$\|\.cpp$\|\.cxx$\|\.cc$' | xargs -i cp {} $2
}

# Identify ROOT and Geant4 installations
rootDir=~/Source/`ls -1 ~/Source | grep "root.*[0-9]$" | tail -1`/
geantDir=~/Source/`ls -1 ~/Source | grep "geant.*[0-9]$" | tail -1`/source/
echo "Found ROOT source directory: $rootDir"
echo "Found Geant4 source directory: $geantDir"

# Copy ROOT and Geant4 sources
destDir=~/Source/root-geant-sources/
rm -rf $destDir && mkdir $destDir
echo "Copying ROOT and Geant4 sources..."
copySources $rootDir $destDir
copySources $geantDir $destDir

# Copy ROOT sources only
destDir=~/Source/root-sources/
rm -rf $destDir && mkdir $destDir
echo "Copying ROOT sources only..."
copySources $rootDir $destDir

cd $destDir
chmod -w ./*
