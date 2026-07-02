#!/bin/bash

# All variables in this file must be set by the user.
# Set these variables by using `source` or `.`: Run `. TrainKibub-VARS.sh`. Do not run `./TrainKibub-VARS.sh`, as this script is a child process that cannot set variables in its parent.

# dataset variables
export DATASET_REPO="oliveoil8888/pick-up-the-cup" # hf tag of the Huggingface dataset you would like to download for training
export TASK="Pick up the cup" # language prompt demonstrated by the dataset

# huggingface auth 
export HF_USER="oliveoil8888" # your huggingface usertag 

# training variables
export STEPS=50000
export BATCH_SIZE=4
export MODEL_REPO="pick-up-cup-model" #the name of your resulting model

# SLURM directives
export SLURM_TIME="00.05.00"

