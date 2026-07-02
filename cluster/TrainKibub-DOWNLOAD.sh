#!/bin/bash

echo "Executing script TrainKibub-DOWNLOAD.sh"

export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot

echo HF_HOME: $HF_HOME
echo HF_LEROBOT_HOME: $HF_LEROBOT_HOME

module load Miniconda3
conda activate $SOFTWARE/$USER/envs/lerobot

. /$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh

hf auth login

# download your demonstrations dataset
# hf download <hf repo tag> --local-dir <local location>
hf download $DATASET_REPO --local-dir $HF_HOME/hub/$DATASET_REPO


