#!/bin/bash

function copySources () {
	# $1 - source folder
	# $2 - destination folder
	find $1 -type f | grep -i '\.c$\|\.cpp$\|\.cxx$\|\.cc$' | xargs -i cp {} $2
}

destDir=~/Source/root-geant-sources/
rootDir=~/Source/`ls -1 ~/Source | grep "root.*[0-9]$"`/
geantDir=~/Source/`ls -1 ~/Source | grep "geant.*[0-9]$"`/source/

echo "Found ROOT source directory: $rootDir"
echo "Found Geant4 source directory: $geantDir"

rm -rf $destDir && mkdir $destDir
copySources $rootDir $destDir
copySources $geantDir $destDir
