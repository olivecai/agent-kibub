#!/bin/bash

echo "Executing script TrainKibub-RUN.sh"
# this script calls TrainKibub-SBATCH.sh
# the only purpose of this script is to pass SLURM directives as cmd line args in the sbatch cmd

# export the slurm directives set by the user
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

echo "Sending job with sbatch now!"

# then pass them as cmd line args 
sbatch --time="$SLURM_TIME" $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-SBATCH.sh
