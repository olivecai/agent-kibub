#!/bin/bash
source "$(conda info --base)/etc/profile.d/conda.sh"
set -e # script will exit on any error

# Run this script on the Robot Policy Server (CUDA Device) to set up the server virtual environment.
echo "PRECAUTIONS TO THE PROGRAMMER: run this script with current working directory as agent-kibub, and without any conda environment activated."

echo "LOGGING: git submodule init and update:"

git submodule init
git submodule update

echo "LOGGING: git pull origin main: (if you need a certain HEAD then specify OR checkout after script finishes)"
git pull origin main

echo "LOGGING: creating conda env:"

conda deactivate 2>/dev/null || true
conda create -n TEST python=3.12 -y
conda activate TEST 

echo "LOGGING: populate the venv:"
pip install -r server_requirements.txt #server-requirements.txt does not contain flash_attn since it is very problematic and seems to fare better installed separately.

echo "LOGGING: installing flash_attn==2.8.3 --no-cache-dir --no-build-isolation"
pip install flash_attn==2.8.3 --no-cache-dir --no-build-isolation

echo "LOGGING: conda environment has finished installing all requirements. Now installing openclaw.ai"
echo "LOGGING: installing openclaw.ai"

curl -fsSL https://openclaw.ai/install.sh | bash

