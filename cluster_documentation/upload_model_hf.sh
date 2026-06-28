#!/bin/bash

# run this on a Login or Transfer Node

echo "This script is used for uploading your trained model to Huggingface. Run this script on a Node with internet access; the Login or Transfer Nodes."

echo "Ensure you are logged into Huggingface, and that you have exported "REPO" and "POLICY" beforehand.

module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot

hf auth login
export HF_USER=$(hf auth whoami | awk -F': ' '/user:/ {print $2}')
export POLICY="groot"

export OUTPUT_DIR=${BIGWORK}/lerobot-run/outputs/train/${POLICY}-${REPO}

hf upload ${HF_USER}/${REPO} $OUTPUT_DIR . --repo-type model

echo "Finished uploading the model to Huggingface."