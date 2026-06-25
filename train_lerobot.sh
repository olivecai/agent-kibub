#!/bin/bash -l
#SBATCH --job-name=lerobot_train
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8G
#SBATCH --gres=gpu:a100:1
#SBATCH --time=08:00:00
#SBATCH --output=lerobot_train_%j.out
#SBATCH --error=lerobot_train_%j.err
#SBATCH --mail-user=nhkwcaio@luis.uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL

cd $SLURM_SUBMIT_DIR

# load conda and activate your environment
module load Miniforge3
conda activate $SOFTWARE/nhkwcaio/lerobot

# confirm GPU is visible
echo "=== GPU Info ==="
nvidia-smi
echo ""

echo "=== Job Info ==="
echo "Node:    $(hostname)"
echo "GPUs:    $SLURM_GPUS"
echo "CPUs:    $SLURM_CPUS_PER_TASK"
echo "Started: $(date)"
echo ""

# point torch to BIGWORK for caching/checkpoints, not HOME
export HF_HOME=$BIGWORK/hf_cache
export TORCH_HOME=$BIGWORK/torch_cache

# run training
srun lerobot-train \
    --policy.type=act \
    --dataset.repo_id=lerobot/pusht \
    --output_dir=$BIGWORK/lerobot_output \
    --num_workers=$SLURM_CPUS_PER_TASK \
    --batch_size=64 \
    --steps=100000 \
    --save_freq=10000 \
    --log_freq=100 \
    --wandb.enable=false

echo ""
echo "Finished: $(date)"
