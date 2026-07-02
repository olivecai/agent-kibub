#!/bin/bash

# Run this script on the Robot Policy Server (CUDA Device) to set up the server virtual environment.
git submodule init
git submodule update
pip install -r requirements.txt

# install the other stuff like pytroch etcccccc
