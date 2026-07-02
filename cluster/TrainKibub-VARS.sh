#!/bin/bash 

#############################
# Edit the variables below  #
#############################
# The DOWNLOAD, RUN, and UPLOAD scripts source this script automatically.

# To simply set variables in the shell, run this script using `source` or `.`: 
# Run `. TrainKibub-VARS.sh`. Do not run `./TrainKibub-VARS.sh`, as this script is a child process that cannot set variables in its parent.

# dataset variables
export DATASET_REPO="oliveoil8888/pick-place-cube-cup-1" # hf tag of the Huggingface dataset you would like to download for training
export TASK="Pick up the cube and place it in the cup." # language prompt demonstrated by the dataset

# huggingface auth 
export HF_USER="oliveoil8888" # your huggingface usertag 

# training variables
export STEPS=50000
export BATCH_SIZE=4
export MODEL_REPO="pick-up-cup-model" #the name of your resulting model

# SLURM directives
export SLURM_TIME="00:05:00"

# Edit no further! Only modify vars above. Do not edit the vars below! 
##########################################
##########################################
##########################################
# Do not edit any of the variables below #
##########################################
export OUTPUT_DIR="${BIGWORK}/lerobot-run/outputs/train/${POLICY}-${MODEL_REPO}"
export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot
export POLICY="groot"