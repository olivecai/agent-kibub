#!/bin/bash -l
#SBATCH --job-name=array_test
#SBATCH --partition=amo
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --array=1-5
#SBATCH --output=array_test_%A_%a.out
#SBATCH --error=array_test_%A_%a.err

# comments:
# %A = the parent job ID, %a = this task's index (1..5)
# SLURM launches 5 independent copies of this script simultaneously,
# each with a different SLURM_ARRAY_TASK_ID.

cd $SLURM_SUBMIT_DIR

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

echo "Array job $SLURM_ARRAY_JOB_ID — task $SLURM_ARRAY_TASK_ID of $SLURM_ARRAY_TASK_COUNT"
echo "Node: $(hostname) — CPUs available: $SLURM_CPUS_PER_TASK"

# Each task does its own independent work using its index.
# In a real job you'd use $SLURM_ARRAY_TASK_ID to pick a different
# input file, parameter value, random seed, etc.
sleep $SLURM_ARRAY_TASK_ID
echo "Task $SLURM_ARRAY_TASK_ID done."
