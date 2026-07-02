#!/bin/bash -l
#SBATCH --job-name=lerobot-groot-train
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=64G
#SBATCH --time=
#SBATCH --output=lerobot-train_%j.out
#SBATCH --error=lerobot-train_%j.err
cd $SLURM_SUBMIT_DIR 
mkdir -p lerobot-run && cd lerobot-run
module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot
export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
export POLICY="groot"

# then specify HF_HUB_OFFLINE=1 to signal that models/datasets will be saved in the local cache
export HF_HUB_OFFLINE=1

# this script will export all your variables :-)
# use `source` or `.` to export vars from child proc
. /$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh

# NOTE: dataset AND base model already downloaded on login node before job submission:
#   hf download ${HF_USER}/${REPO} --repo-type dataset --local-dir ${HF_LEROBOT_HOME}/${HF_USER}/${REPO}
#   hf download nvidia/GR00T-N1.5-3B --local-dir ${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B

# this is where the model checkpoints will be saved

export OUTPUT_DIR=${BIGWORK}/lerobot-run/outputs/train/${HF_USER}/${POLICY}/${MODEL_REPO}

srun lerobot-train \
  --dataset.repo_id=${DATASET_REPO} \
  --dataset.root=${HF_LEROBOT_HOME}/${DATASET_REPO} \
  --dataset.video_backend=pyav \
  --policy.type=${POLICY} \
  --policy.base_model_path=${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B \
  --policy.push_to_hub=false \
  --output_dir=$OUTPUT_DIR \
  --job_name=job-${HF_USER}-${MODEL_REPO} \
  --policy.device=cuda \
  --wandb.enable=false \
  --steps=${STEPS} \
  --batch_size=${BATCH_SIZE} \
  --save_checkpoint=true
