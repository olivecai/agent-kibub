#!/bin/bash

# Run this script on the Robot Policy Server (CUDA Device) to set up the server virtual environment.
echo "PRECAUTIONS TO THE PROGRAMMER: run this script with current working directory as agent-kibub"



echo "LOGGING: git submodule inti and update:"

git submodule init
git submodule update

echo "LOGGING: creating conda env:"

conda create -n lerobot python=3.12 -y
conda activate lerobot 

echo "LOGGING: populate the venv:"

pip install -r server-requirements.txt
pip install flash_attn==2.8.3 --no-cache-dir --no-build-isolation