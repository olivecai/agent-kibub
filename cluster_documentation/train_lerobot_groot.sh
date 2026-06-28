#!/bin/bash -l
#SBATCH --job-name=lerobot-groot-train
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --output=lerobot-train_%j.out
#SBATCH --error=lerobot-train_%j.err
cd $BIGWORK 
mkdir -p lerobot-run && cd lerobot-run
module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot
export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
export POLICY="groot"
export HF_HUB_OFFLINE=1
# MODIFY THESE VARS FOR YOUR PURPOSES!
export HF_USER="oliveoil8888"
REPO=pick-up-cup-jun28-1
TASK="Pick up the cup"
STEPS=50000
BATCH_SIZE=4


# NOTE: dataset AND base model already downloaded on login node before job submission:
#   hf download ${HF_USER}/${REPO} --repo-type dataset --local-dir ${HF_LEROBOT_HOME}/${HF_USER}/${REPO}
#   hf download nvidia/GR00T-N1.5-3B --local-dir ${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B

export OUTPUT_DIR=${BIGWORK}/lerobot-run/outputs/train/${POLICY}-${REPO}

srun lerobot-train \
  --dataset.repo_id=${HF_USER}/${REPO} \
  --dataset.root=${HF_LEROBOT_HOME}/${HF_USER}/${REPO} \
  --dataset.video_backend=pyav \
  --policy.type=${POLICY} \
  --policy.base_model_path=${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B \
  --policy.push_to_hub=false \
  --output_dir=$OUTPUT_DIR \
  --job_name=job-${REPO}-cluster-test \
  --policy.device=cuda \
  --wandb.enable=false \
  --steps=${STEPS} \
  --batch_size=${BATCH_SIZE} \
  --save_checkpoint=true
