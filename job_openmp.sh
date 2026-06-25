#!/bin/bash -l
#SBATCH --job-name=openmp_test
#SBATCH --partition=amo
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --output=openmp_test_%j.out
#SBATCH --error=openmp_test_%j.err

# ntasks=1 + cpus-per-task=4 means: one process, using 4 cores on the SAME node.
# This is the OpenMP pattern (shared memory).

cd $SLURM_SUBMIT_DIR

echo "Job $SLURM_JOB_ID on $(hostname) — using $SLURM_CPUS_PER_TASK CPUs"

# Tell OpenMP-aware programs how many threads to use.
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Demo: launch 4 background tasks to simulate parallel work.
for i in $(seq 1 $SLURM_CPUS_PER_TASK); do
    echo "  Worker $i starting..." &
    sleep 2 &
done
wait   # wait for all background tasks to finish

echo "All workers done."
