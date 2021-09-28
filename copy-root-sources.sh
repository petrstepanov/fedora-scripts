#!/bin/bash

function copySources () {
	# $1 - source folder
	# $2 - destination folder
	find $1 -type f | grep -i '\.c$\|\.cpp$\|\.cxx$\|\.cc$' | xargs -i cp {} $2
}

# Identify ROOT and Geant4 installations
rootDir=~/Source/`ls -1 ~/Source | grep "root.*[0-9]$" | tail -1`/
echo "Found ROOT source directory: $rootDir"

# Copy ROOT sources only
destDir=~/Source/root-sources/
rm -rf $destDir && mkdir $destDir
echo "Copying ROOT sources only..."
copySources $rootDir $destDir

cd $destDir
chmod -w ./*
