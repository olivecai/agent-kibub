#!/bin/bash -l
#SBATCH --job-name=lerobot-groot-train-TEST
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=64G
#SBATCH --time=00:20:00
#SBATCH --output=lerobot-train-test_%j.out
#SBATCH --error=lerobot-train-test_%j.err
cd $BIGWORK # documentation says to run `cd $SLURM_SUBMIT_DIR` but we can intentionally>
mkdir -p lerobot-run && cd lerobot-run
module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot
export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
REPO=pick-up-cup-left-overhead-4-2-merge
TASK="Pick up the cup"
POLICY="groot"
HF_USER="oliveoil8888"
STEPS=50
BATCH_SIZE=4
# NOTE: dataset AND base model already downloaded on login node before job submission:
#   hf download ${HF_USER}/${REPO} --repo-type dataset --local-dir ${HF_LEROBOT_HOME}/$>
#   hf download nvidia/GR00T-N1.5-3B --local-dir ${HF_HOME}/hub/models--nvidia--GR00T-N>
srun lerobot-train \
  --dataset.repo_id=${HF_USER}/${REPO} \
  --dataset.root=${HF_LEROBOT_HOME}/${HF_USER}/${REPO} \
  --dataset.video_backend=pyav \
  --policy.type=${POLICY} \
  --policy.base_model_path=${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B \
  --policy.push_to_hub=false \
  --output_dir=${BIGWORK}/lerobot-run/outputs/train/${POLICY}-${REPO}-cluster-test \
  --job_name=job-${REPO}-cluster-test \
  --policy.device=cuda \
  --wandb.enable=false \
  --steps=${STEPS} \
  --batch_size=${BATCH_SIZE} \
  --save_checkpoint=true

