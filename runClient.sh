#!/bin/bash

cd build
xhost +
sudo DISPLAY=:0 ./wxmoni_bin
