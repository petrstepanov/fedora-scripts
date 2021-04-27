#!/bin/bash

echo "Installing launchers..."

xdg-desktop-menu install ./launchers/*
xdg-desktop-menu forceupdate

echo "Done."

