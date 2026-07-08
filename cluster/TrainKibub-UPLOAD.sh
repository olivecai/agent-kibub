#!/bin/bash 

# run this on a Login Node (Transfer Node does not have access to $SOFTWARE)
echo "Executing script TrainKibub-UPLOAD.sh"

echo "This script is used for uploading your trained model to Huggingface. Run this script on the Login node."
echo "Ensure you are logged into Huggingface, and that you have exported "REPO" and "POLICY" beforehand."

module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot

. $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh

echo "DATASET_REPO" $DATASET_REPO
echo "TASK" $TASK

# training variables
echo "STEPS" $STEPS
echo "BATCH_SIZE" $BATCH_SIZE
echo "MODEL_REPO" $MODEL_REPO

# SLURM directives
echo "SLURM_TIME" $SLURM_TIME

echo OUTPUT_DIR $OUTPUT_DIR

echo HF_HOME: $HF_HOME
echo HF_LEROBOT_HOME: $HF_LEROBOT_HOME

hf auth login
export HF_USER=$(hf auth whoami | awk -F': ' '/user:/ {print $2}') 

echo HF_USER $HF_USER

hf upload ${HF_USER}/${MODEL_REPO} $OUTPUT_DIR/checkpoints/last/pretrained_model . --repo-type model

echo "Finished uploading the model to Huggingface."