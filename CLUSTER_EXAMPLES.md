
## using file systems
```
# where are you? lost? print working directory!
pwd
# change directory to your bigwork/project/home directory
cd $BIGWORK
cd $PROJECT
cd $HOME
# display your home, bigwork & project quota
checkquota
# make personal directory in your group's project storage
# set permissions (-m) so only your account can access
# the files in it (0700)
mkdir -m 0700 $PROJECT/$USER
# copy the directory mydir from bigwork to project
cp -r $BIGWORK/mydir $PROJECT/$USER
```

## set stripe count
```
# get overall bigwork usage, note different fill levels
lfs df -h
# get current stripe settings for your bigwork
lfs getstripe $BIGWORK
# change directory to your bigwork
cd $BIGWORK
# create a directory for large files (anything over 100 MB)
mkdir LargeFiles
# get current stripe settings for that directory
lfs getstripe LargeFiles
# set stripe count to -1 (all available OSTs)
lfs setstripe -c -1 LargeFiles
# check current stripe settings for LargeFiles directory
lfs getstripe LargeFiles
# create a directory for small files
mkdir SmallFiles
# check stripe information for SmallFiles directory
lfs getstripe SmallFiles
```

## altering stripe count
```
# enter the directory for small files
cd SmallFiles
# create a 100 MB file
dd if=/dev/zero of=100mb.file bs=10M count=10
# check filesize by listing directory contents
ls -lh
# check stripe information on 100mb.file
lfs getstripe 100mb.file
# move the file into the large files directory
mv 100mb.file ../LargeFiles/
# check if stripe information of 100mb.file changed
lfs getstripe ../LargeFiles/100mb.file
# remove the file
rm ../LargeFiles/100mb.file
```

## change stripe (DONT USE mv) 
### method 1
```
# from within the small files directory
cd $BIGWORK/SmallFiles
# create a 100 MB file
dd if=/dev/zero of=100mb.file bs=10M count=10
# copy file into the LargeFiles directory
cp 100mb.file ../LargeFiles/
# check stripe in the new location
lfs getstripe ../LargeFiles/100mb.file
```
### method 2
```
# create empty file with appropriate stripe count
lfs setstripe -c -1 empty.file
# check stripe information of empty file
lfs getstripe empty.file
# copy file "in place"
cp 100mb.file empty.file
# check that empty.file now has a size of 100 MB
ls -lh
# remove the original 100mb.file and work with empty.file
rm 100mb.file
```

## submits an interactive job that requests 12 tasks (this corresponds to 12 MPI ranks) on two compute nodes and 4 GB memory per CPU core for an hour:
```
[user@login02 ~]$ salloc --time=1:00:00 --nodes=2 --ntasks=12 --mem-per-
cpu=4G --x11
salloc: slurm_job_submit: set partition of submitted job to amo,tnt,gih
salloc: Pending job allocation 27477
salloc: job 27477 queued and waiting for resources
salloc: job 27477 has been allocated resources
salloc: Granted job allocation 27477
salloc: Waiting for resource configuration
salloc: Nodes amo-n[001-002] are ready for job
[user@amo-n001 ~]$
# option --x11 sets up X11 forwarding on the first(master) compute node enabling the use of graphical applications.
'''
If you do not explicitly specify memory and time parameters for your job, the corresponding
default values for the cluster partition to which the job will be assigned will be used. To find out the
default time and memory settings for a partition, e.g. amo, look at the DefaultTime and
DefMemPerCPU values in the scontrol show partitions amo command output.

In case you get an error message like srun: Warning: can't honor --ntasks-per-
node set to X which doesn't match the requested tasks YY with the number of
requested nodes ZZ. Ignoring, check (using set | grep SLURM_N within the job shell, for
example) that your request has been honored despite the message, and then ignore the message.
'''
```

##  simple serial job script (save the lines to the file test_serial.sh)
```
#!/bin/bash -l
#SBATCH --job-name=test_serial
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:20:00
#SBATCH --constraint=[CPU_ARCH:avx512|CPU_ARCH:avx2]
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output test_serial-job_%j.out
#SBATCH --error test_serial-job_%j.err
# Change to my work dir
# SLURM_SUBMIT_DIR is an environment variable that automatically gets
# assigned the directory from which you did submit the job. A batch job
# is like a new login, so you'll initially be in your HOME directory.
# So it's usually a good idea to first change into the directory you
did
# submit your job from.
cd $SLURM_SUBMIT_DIR
# Load the modules you need, see corresponding page in the cluster
documentation
module load my_modules
# Start my serial app
# srun is needed here only to create an entry in the accounting system,
# but you could also start your app without it here, since it's only
serial.
srun ./my_serial_app
```
**submit the batch job:** `sbatch example_serial_slurm.sh`

'''
Note: as soon as compute nodes are allocated to your job, you can establish an ssh connection from
the login machines to these nodes.
Note: if your job oversteps the resource limits that you have defined in your #SBATCH directives, the
job will automatically be killed by the SLURM server. This is particularly the case when you try to use
more memory than you allocated, which results in an OOM (out-of-memory) -event.
'''

## Example of an OpenMP job 
For OpenMP jobs, you will need to set --cpus-per-task to a value larger than one and explicitly
define the OMP_NUM_THREADS variable. The example script launches eight threads, each with 2 GiB
of memory and a maximum run time of 30 minutes.
```
#!/bin/bash -l
#SBATCH --job-name=test_openmp
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:30:00
#SBATCH --constraint=[CPU_ARCH:avx512|CPU_ARCH:avx2]
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output test_openmp-job_%j.out
#SBATCH --error test_openmp-job_%j.err
# Change to my work dir
cd $SLURM_SUBMIT_DIR
# Bind your OpenMP threads
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
# Intel compiler specific environment variables
export KMP_AFFINITY=verbose,granularity=core,compact,1
export KMP_STACKSIZE=64m
## Load modules
module load my_module
# Start my application
srun ./my_openmp_app
```

## Example of an MPI job
This example requests 10 compute nodes on the lena cluster with 16 cores each and 320 GiB of
memory in total for a maximum duration of 2 hours.
```
#!/bin/bash -l
#SBATCH --job-name=test_mpi
#SBATCH --partition=lena
#SBATCH --nodes=10
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=2G
#SBATCH --time=02:00:00
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output test_mpi-job_%j.out
#SBATCH --error test_mpi-job_%j.err
# Change to my work dir
cd $SLURM_SUBMIT_DIR
# Load modules
module load foss/2018b
# Start my MPI application
#
# Note: if you use Intel MPI Library provided by modules up to
intel/2020a, execute srun as
#
# srun --mpi=pmi2 ./my_mpi_app
#
# For all Intel MPI libraries set the environment variable
I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so before executing srun
srun --cpu_bind=cores --distribution=block:cyclic ./my_mpi_app

```

## Example MPI Multi srun slurm 
```
#!/bin/bash -l
#SBATCH --job-name=test_mpi
#SBATCH --partition=lena
#SBATCH --nodes=12
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:02:00
#SBATCH --constraint=[CPU_ARCH:avx512|CPU_ARCH:avx2]
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output test_mpi-job_%j.out
#SBATCH --error test_mpi-job_%j.err
# Change to my work dir
cd $SLURM_SUBMIT_DIR
# Load modules
module load foss/2018b
# Start my MPI application
srun --cpu_bind=cores --distribution=block:cyclic -N 4 --ntasks-per-
node=16 --exclusive ./my_mpi_app_1 &
srun --cpu_bind=cores --distribution=block:cyclic -N 4 --ntasks-per-
node=16 --exclusive ./my_mpi_app_1 &
srun --cpu_bind=cores --distribution=block:cyclic -N 4 --ntasks-per-
node=16 --exclusive ./my_mpi_app_2 &
wait
```
Note the wait command in the script; it results in the script waiting for all previously commands that
were started with \$&\$ (execution in the background) to finish before the job can complete.
take care that the time necessary to complete each subjob is not too different in order not to
waste too much valuable cpu time

## Job Array slurm example
```
#!/bin/bash -l
#SBATCH --job-name=test_job_array
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:20:00
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --array=1-10,15,18
#SBATCH --output test_array-job_%A_%a.out
#SBATCH --error test_array-job_%A_%a.err
# Change to my work dir
cd $SLURM_SUBMIT_DIR
# Load modules
module load my_module
# Start my app
srun ./my_app $SLURM_ARRAY_TASK_ID
```

## GPU slurm example
```
#!/bin/bash -l
#SBATCH --job-name=test_gpu
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --gres=gpu:v100:2
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:30:00
#SBATCH --mail-user=user@uni-hannover.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output test_gpu-job_%j.out
#SBATCH --error test_gpu-job_%j.err
# Change to my work dir
cd $SLURM_SUBMIT_DIR
# Load modules
module load fosscuda/2018b
# Run GPU application
srun ./my_gpu_app
```
When submitting a job to the gpu partition, you must specify the number of GPUs. Otherwise, your
job will be rejected at the submission time. To access GPUs in the gpu partition, the partition must be
explicitly specified, as requesting GPUs alone (e.g. --gres=gpu:2) does not cause the gpu partition
to be considered.

## conda example
```
#!/bin/bash -l
#SBATCH --job-name=my-conda-application
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=60G
#SBATCH --time=00:30:00
#SBATCH --mail-user=user@yourinstitute.uni-hannover.de
#SBATCH --mail-type=END
# Activate your conda environment
module load Miniforge3
conda activate <your_conda_env_name>
# Run app
```