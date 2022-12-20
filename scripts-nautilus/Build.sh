#!/bin/bash

source env
rm -rf $1-build
mkdir $1-build
cd $1-build
cmake ../$1
make -j4
make install
