#!/bin/bash -l
#SBATCH --job-name=hello_test
#SBATCH --partition=amo
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --output=hello_test_%j.out
#SBATCH --error=hello_test_%j.err

# Change to the directory you submitted from
cd $SLURM_SUBMIT_DIR

echo "=== Job Info ==="
echo "Job ID:    $SLURM_JOB_ID"
echo "Job Name:  $SLURM_JOB_NAME"
echo "Node:      $(hostname)"
echo "Date:      $(date)"
echo ""

echo "=== Doing some work ==="
for i in 1 2 3; do
    echo "Step $i of 3..."
    sleep 1
done

echo ""
echo "Done! Job finished at $(date)"
