#!/bin/bash 

# run this on a Login Node (Transfer Node does not have access to $SOFTWARE)
echo "Executing script TrainKibub-DOWNLOAD.sh"

module load Miniconda3
conda activate $SOFTWARE/$USER/envs/lerobot

. /$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh


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

# download your demonstrations dataset
# hf download <hf repo tag> --local-dir <local location>
hf download $DATASET_REPO --repo-type dataset  --local-dir $HF_HOME/hub/$DATASET_REPO