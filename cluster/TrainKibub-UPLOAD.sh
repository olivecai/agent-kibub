#!/bin/bash

# run this on a Login or Transfer Node
echo "Executing script TrainKibub-UPLOAD.sh"

echo "This script is used for uploading your trained model to Huggingface. Run this script on the Login node."
echo "Ensure you are logged into Huggingface, and that you have exported "REPO" and "POLICY" beforehand.

module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot

hf auth login
export HF_USER=$(hf auth whoami | awk -F': ' '/user:/ {print $2}') 
export POLICY="groot"

. /$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh

export OUTPUT_DIR=${BIGWORK}/lerobot-run/outputs/train/${HF_USER}/${POLICY}/${MODEL_REPO}

hf upload ${HF_USER}/${MODEL_REPO} $OUTPUT_DIR . --repo-type model

echo "Finished uploading the model to Huggingface."