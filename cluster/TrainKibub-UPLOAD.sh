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
echo HF_USER $HF_USER

. /$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh

echo "DATASET_REPO" $DATASET_REPO
echo "TASK" $TASK

# huggingface auth 
echo "HF_USER" $HF_USER

# training variables
echo "STEPS" $STEPS
echo "BATCH_SIZE" $BATCH_SIZE
echo "MODEL_REPO" $MODEL_REPO

# SLURM directives
echo "SLURM_TIME" $SLURM_TIME

export OUTPUT_DIR=${BIGWORK}/lerobot-run/outputs/train/${HF_USER}/${POLICY}-${MODEL_REPO}

echo OUTPUT_DIR $OUTPUT_DIR

hf upload ${HF_USER}/${MODEL_REPO} $OUTPUT_DIR . --repo-type model

echo "Finished uploading the model to Huggingface."