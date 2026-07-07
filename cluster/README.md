# Cluster Computing Intro

Created by: Olivia Cai

Date: June 25 2026 - July 2 2026

*Table of Contents:*

1. Cluster computing jargon definitions
2. Cluster computing job types
3. Warnings w.r.t. to the cluster
4. Setting up your cluster workspace (General + Training GR00t models for Kibub via Lerobot scripts)
5. Creating & running a job (General + Training GR00t models for Kibub via Lerobot scripts)
6. Cleaning up

## Cluster computing jargon definitions

| Term | Simple definition |
|------|--------------------|
| **Thread** | the smallest sequence of instructions that an operating system's scheduler can manage independently |
| **Core** | independent processing unit within a CPU or GPU capable of executing instructions. (CPUs usually have 4-8 cores, GPUs thousands) |
| **Partition** | a group of compute nodes managed by a scheduler, often configured for a specific type of hardware or workload (e.g., CPU-only or GPU-enabled nodes). |
| **Node** | a single computer in a cluster (e.g. Login or Transfer nodes or Computing nodes amo, lena, etc), typically containing one or more CPUs/GPUs, memory (RAM), storage. |
| **Rank** | an MPI process. Each rank has a unique ID and executes a portion of a parallel program. |
| **CPU (Central Processing Unit)** | general-purpose processor that runs the operating system and most application code. |
| **GPU (Graphics Processing Unit)** | a processor designed to execute thousands of operations simultaneously; ideal for highly parallel workloads. |
| **CUDA (Compute Unified Device Architecture)** | NVIDIA's programming platform and API for writing programs that execute on NVIDIA GPUs. |
| **InfiniBand** | high-speed, low-latency network technology commonly used to connect nodes in high-performance computing (HPC) clusters. |
| **Gigabit Ethernet** | A network technology capable of transferring data at up to 1 Gbit/s, commonly used for general-purpose networking and smaller computing clusters. |

## Cluster computing job types

See the table below for a cheatsheet differentiating job types; Serial, Job array, Open Multi-Processing (OpenMP), Message Passing Interface (MPI), and GPU:

| Job Type      | Parallel units                       | Nodes                                                | Cores                                                  | Do threads communicate?                                                                      | Notes                                                                                         |
| ------------- | ------------------------------------ | ---------------------------------------------------- | ------------------------------------------------------ | -------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Serial**    | 1 serial CPU thread                  | Strictly 1 CPU node                                  | Strictly 1 CPU core                                    | N/A, since only 1 thread exists.                                                             | Basic single-threaded execution.                                                              |
| **Job array** | *k* independent CPU threads          | ≥1 CPU nodes; threads are independent                | *k* CPU cores                                          | No; each task is independent.                                                                | Embarrassingly parallel (e.g., independent matrix multiplications or parameter sweeps).       |
| **OpenMP**    | 1 process with *k* CPU threads       | Strictly 1 CPU node; all threads access the same RAM | *k* CPU cores                                          | Yes, via shared CPU RAM; therefore all threads run on one node.                              | Shared-memory parallel programming.                                                           |
| **MPI**       | *k* processes                        | Protocol works on ≥1 CPU nodes                       | *k* CPU cores                                          | Yes, via message passing (e.g., InfiniBand, TCP).                                            | Distributed-memory parallel computing.                                                        |
| **GPU**       | Thousands to millions of GPU threads | ≥1 CPU node with ≥1 GPU                              | 1–8 CPU cores to launch/control thousands of GPU cores | CPU cores do not share memory for GPU execution, but GPU threads communicate via GPU memory. | CPUs prepare/manage data and launch kernels; GPUs perform the massively parallel computation. |

## Warnings w.r.t. the cluster
- Don't use sudo; you'll get the message: `USER is not in the sudoers file.  This incident will be reported.`
- Don't save sensitive information into communal spaces unless permissions are 0700 (rwx for owner only)
- Clean up; remove large datasets and output models from storage, since operations can fail if you run out of space for saving checkpoints

# Setting up your cluster workspace

## Initial Setup (General)

*General setup for organizing your workspace. The following instructions are intentionally vague to act as a general guide. Skip this section and Ctrl+F "Initial Setup (Training GR00t models for Kibub via Lerobot scripts)" for specific instructions on training Groot VLA models on Kibub.*

1. Obtain your LUIS cluster username and password, $USER and $PASSWORD
2. SSH into the Login Node: `ssh ${USER}@transfer.cluster.uni-hannover.de` and copy in your PASSWORD when prompted (for security reasons, the shell does not echo the typical "*" or "#" symbols during password input)
2. Create your cluster workspaces in $PROJECT and $SOFTWARE:
    ```
    mkdir -m 0700 $PROJECT/$USER
    mkdir -m 0700 $SOFTWARE/$USER
    ```
    You can double check the existence of your newly created directories by running `ls $PROJECT` or `ls $SOFTWARE`. 
2. Use scp to the Transfer Node to transfer files from client local to the cluster:`scp current/location $USER@transfer.cluster.uni-hannover.de:desired/cluster/location` (if the Computing Nodes need access to the file during computation, transfer files into subdirectories of $BIGWORK and/or $SOFTWARE, since Computing Nodes do not have access to $PROJECT.)
3. SSH into the Login Node: `ssh $USER@login.cluster.uni-hannover.de`
4. If you would like to use conda environments: load Miniconda and then create a conda env located in your $SOFTWARE/$USER folder: `module load Miniconda3; conda create --prefix $SOFTWARE/$USER/envs/my_env`
6. Clone necessary Github repositories: `cd $SOFTWARE/$USER; git clone my_repository_url`
7. Install necessary packages into your environment. If you have a requirements.txt, you can run: `conda activate $SOFTWARE/$USER/environments/my_env; pip install -r requirements.txt`. (To generate a requirements.txt of a pre-existing local env, run the following steps on your local computer: activate the environment you would like to replicate via `conda activate local_env`, generate requirements.txt via `pip freeze > requirements.txt`, and transfer requirements.txt into the cluster directory $SOFTWARE/$USER via `scp requirements.txt $USER@transfer.cluster.uni-hannover.de:$SOFTWARE/$USER`. Finally, switch over to the cluster SSH session and execute `pip install -r requirements.txt`)
8. You have finished the initial setup. You now have the following in your inventory:

- directory $PROJECT/$USER
- directory $SOFTWARE/$USER
- conda env, with packages installed from requirements.txt
- Github repositories

Depending on your application, you will likely need to load other modules or export shell variables. In your future SLURM scripts, don't forget to include the line `module load X` for each module you use, including `Miniconda3`. 

## Initial Setup (Training GR00t models for Kibub via Lerobot scripts)

The following instructions are specifically created for training Groot VLA models on Kibub on June 26 2026, and also serve as a detailed example if you would like to use conda environments. 

1. Let USER be your cluster username; SSH into the cluster Login Node: `ssh ${USER}@transfer.cluster.uni-hannover.de`.

  Example:
 ```   
(base) ocai@cowmatch005:~$ ssh nhkwcaio@login.cluster.uni-hannover.de
The authenticity of host 'login.cluster.uni-hannover.de (130.75.7.130)' can't be established.
ED25519 key fingerprint is SHA256:sG8ZYabQctyGjxPD7X8K2IBxJIE5xHHZ9mQqjlVcjxo.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'login.cluster.uni-hannover.de' (ED25519) to the list of known hosts.
(nhkwcaio@login.cluster.uni-hannover.de) Password: 
# Enter your password and you should enter the cluster!
```

2. Now in your SSH session, create your workspaces in $PROJECT and $SOFTWARE:
```
mkdir -m 0700 ${PROJECT}/${USER}
mkdir -m 0700 ${SOFTWARE}/${USER}
```
You can double check the existence of your newly created directories by running `ls $PROJECT` or `ls $SOFTWARE`.

3. Authenticate into Github via SSH:

  You can safely store your SSH key in ${HOME} on the cluster, since only the owner has rwx permissions(double check this by running `ls -ld $HOME`). Generate the SSH key: `ssh-keygen -t ed25519 -C "your_github_email@domain.ca"; cat ~/.ssh/id_ed25519.pub`. Copy your public key. On the Github site https://github.com/settings/keys: Settings > Access > SSH and GPG keys > New SSH Key > let Title == something like "LUH cluster", Key type == Authentication, and paste in the copied output from `cat ~/.ssh/id_ed25519.pub`. 

  Example:
```
  nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ ls -ld $HOME
drwx------ 11 nhkwcaio NHKW25031 4096 Jul  2 10:21 /home/nhkwcaio

  nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ ssh-keygen -t ed25519 -C "ocai@ualberta.ca"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/nhkwcaio/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/nhkwcaio/.ssh/id_ed25519
Your public key has been saved in /home/nhkwcaio/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:k6aa+T+Xz/cFwzJ3ZN8K6GAel6SKkrk6XougKmvrFSQ ocai@ualberta.ca
The key's randomart image is:
+--[ED25519 256]--+
|                 |
|                 |
| E .      .     o|
|  o      + o . oo|
|   .    S + + = +|
|   o.. * *   = = |
|. +o. o . ..  . .|
|=.+o.+  . o.  . .|
|@Oo.+....o .o. ..|
+----[SHA256]-----+
nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ cat ~/.ssh/id_ed25519.pub #this outputs your public key
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdpYufWFsxTlZiRYZT/DG5C3YSSS6j+pvAVhxuj1J49 ocai@ualberta.ca

# then, login to Github and add your SSH key for the cluster device.
```

4. Clone agent-kibub into `${SOFTWARE}/${USER}` by running the following: `cd ${SOFTWARE}/${USER}; git clone https://github.com/olivecai/agent-kibub.git`. (agent-kibub is the master repository for all repositories needed to control, train, and evaluate both VLAs and the OpenClaw agent on Kibub)

5. Initialize/update the git submodules. Expect this process to be slower than on your personal PC:
```
cd agent-kibub
git submodule init
git submodule update
```

Example:
  ```
nhkwcaio@login01:/software/NHKW25031/nhkwcaio$ cd agent-kibub
git submodule init
git submodule update
Cloning into '/software/NHKW25031/nhkwcaio/agent-kibub/kibub-neck-servos'...
Cloning into '/software/NHKW25031/nhkwcaio/agent-kibub/kibub_diff_drive'...
Cloning into '/software/NHKW25031/nhkwcaio/agent-kibub/kibub_operator'...
Cloning into '/software/NHKW25031/nhkwcaio/agent-kibub/lerobot'...
Cloning into '/software/NHKW25031/nhkwcaio/agent-kibub/openclaw-embodied'...
Submodule path 'kibub-neck-servos': checked out '1cf39ca7da8581378ce61b0300dc43eb97fa65c8'
Submodule path 'kibub_diff_drive': checked out '0cde00a1e4711ca995e222eaf0e162a1dc784def'
Submodule path 'kibub_operator': checked out '4f6f7751a4e58a433b302625c8ab0a3efdd3f6e3'
Submodule path 'lerobot': checked out '6e6a3b963c5f0425a380daf21a40c17f82f50d06'
Submodule path 'openclaw-embodied': checked out '410d05fec9794f33d22340ce7ad5bd937dc218ca'
nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ ls
cluster            lerobot
kibub_diff_drive   openclaw-embodied
kibub-neck-servos  quick_commands.txt
kibub_operator     README.md
  ```

6. Load the module Miniconda3 and subsequently create a conda env with python 3.12: `module load Miniconda3; conda create --prefix $SOFTWARE/$USER/envs/lerobot python=3.12 -y`

Example:
```
Module for Miniconda3, version 24.7.1-0 loaded


# this takes around 2-4 min ...

# To activate this environment, use                             
#                                                               
#     $ conda activate /software/NHKW25031/nhkwcaio/envs/lerobot
#                                                               
# To deactivate an active environment, use                      
#                                                               
#     $ conda deactivate  
```

7. Activate the environment: `conda activate ${SOFTWARE}/${USER}/envs/lerobot`. WARNING: Ensure you are not already inside of a venv. Venv inception does not give good results.

Example:
```
nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ conda activate ${SOFTWARE}/${USER}/envs/lerobot
(lerobot) nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ 

```

8. Run `module load cuDNN/9.5.0.50-CUDA-12.6.0`:

Example:
```
Module for CUDA, version 12.6.0 loaded
Module for cuDNN, version 9.5.0.50-CUDA-12.6.0 loaded
```

9. Run `export CUDA_HOME=$EBROOTCUDA`

Example:
```
(lerobot) nhkwcaio@login01:/software/NHKW25031/nhkwcaio/agent-kibub$ echo $EBROOTCUDA
/sw/apps/software/arch/Core/CUDA/12.6.0

```

10. Run the following commands **in order**. Flash-attn is compiled against pre-existing packages; install packages in requirements.txt (includes torch and transformers) first. Attempt the following commands one at a time, since this process has been a bit finicky for me and you may run into complications. This process might also take a while.
```
# might take 10-20 min:

pip install -r ${SOFTWARE}/${USER}/agent-kibub/cluster/requirements.txt 

# flash-attn (if this step fails, ensure you have loaded CUDA modules, exported CUDA_HOME, installed torch, are in the correct virtual environment and not accidentally in a venv instantiated inside another venv, and use --no-build-isolation and --no-cache-dir flags. This package can be finicky to install)

pip install flash_attn==2.8.3 --no-cache-dir --no-build-isolation

```

11. Download GR00t and Eagle base models; finetuning your policies requires these base models to be locally downloaded for the Computing Node to access during the job:
```
module load Miniforge3
conda activate $SOFTWARE/$USER/envs/lerobot

export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
export HF_LEROBOT_HOME=$HF_HOME/lerobot

hf download nvidia/GR00T-N1.5-3B \
  --local-dir ${HF_HOME}/hub/models--nvidia--GR00T-N1.5-3B

hf download lerobot/eagle2hg-processor-groot-n1p5 \
  --local-dir ${HF_HOME}/lerobot/lerobot/eagle2hg-processor-groot-n1p5
```

12. Run: `chmod a+x $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-*`

## Finished!

You are now ready to train GR00t policies (& more) on the cluster!

# Creating & running a job

## Creating & running a job (General)

*Skip this section and Ctrl+F "Creating & running a job (Training GR00t models for Kibub via Lerobot scripts)" for specific instructions on training Groot VLA models on Kibub.*

Requirements:

1. Script
1. Dataset

*And, if you are training a ML policy, you may also require:*

4. Pretrained model 

*You will also have your environment and Github repositories from the initial setup:*

4. Environment
5. Github repositories

Below are guidelines on setting up each of these components:

### Script

Your bash script is what the Computing Nodes will execute.

In your bash script, use the SLURM directives to specify characteristics, resources, constraints, etc.

Ctrl+F 'Cluster computing job types' to see what kind of job you might have; see below for bash variables needed and the table for a guideline on setting #SBATCH directives.

#### Script Directives 

Refer to the LUIS documentation for details on directives or CLUSTER_EXAMPLES.md for a list of important examples from the documentation.

A quick description and cheatsheet is provided below:

**Serial**: 1 process on 1 core on 1 node. 

**Job Array**: 1 process spawning k tasks on cores that are not necessarily on the same node, since memory between threads does not need to be shared; the same script is run many times simultaneously, each with a different index (`$SLURM_ARRAY_TASK_ID`). Each task in the array is itself a serial job. An example of **embarrassingly parallel** tasks.

**OpenMP**: 1 process on n cores (in other words, there are n threads) on 1 node. Use this for programs written with `#pragma omp` or that set `OMP_NUM_THREADS`; parallelism is handled by the runtime, not SLURM. Memory between threads needs to be shared, which is why all cores have to be on the same node (*unlike* the job array).

**MPI**: n processes over k cores. Multiple independent processes that communicate explicitly by passing messages over the network. Use this when your job needs more cores or memory than a single node can provide. Requires an MPI-aware module (e.g. `foss`) and that the program itself calls MPI functions.

**GPU**: Runs a program that offloads compute to one or more GPUs. Requires specifying `--gres` to claim GPUs, and `--partition=gpu` to route to nodes that have the gpu partition. Use a CUDA-enabled module (e.g. `fosscuda`).

Job Type | ntasks | mem-per-cpu | cpus-per-task | nodes | ntasks-per-node | array | gres | partition | module load
--- | --- | --- | --- | --- | --- | --- | --- | --- | ---
Serial | 1 | `nG` | — | — | — | — | — | `<partition>` | `module load <mod>`
Job Array | 1 | `nG` | — | — | — | `1-k` | — | `<partition>` | `module load <mod>`
OpenMP | 1 | `nG` | `k` | — | — | — | — | `<partition>` | `module load <mod>`
MPI | — | `nG` | — | `n` | `k` | — | — | `<partition>` | `module load foss/<ver>`
GPU | — | `nG` | — | `n` | `k` | — | `gpu:<model>:k` | `gpu` | `module load fosscuda/<ver>`

### Dataset

Computing nodes do not have access to internet.

If you have a **locally saved dataset**: use the Transfer Node to scp your locally saved dataset to $BIGWORK/dataset_dir

If you have an **online dataset** saved to a hub like Huggingface: on the Transfer Node (which has internet access), authenticate to your dataset hub and download the dataset into $BIGWORK or $SOFTWARE.

You can save your dataset anywhere that the Computing Nodes have access to.

Ensure that your SLURM script attempts to search the local cache and not only the internet for your dataset.

### Pretrained models

Again, computing nodes do not have internet access; 

If you require a pretrained online model (which is the common case if you are finetuning a base VLA model etc) download that model into $SOFTWARE or $BIGWORK at a specified path.

Ensure that your SLURM script attempts to search the local cache and not only the internet for your model.

If you are using HF models, then run `export HF_HUB_OFFLINE=1`

### Environment

In your script, before utilizing tools from your conda env:
```
module load Miniconda3
conda activate /path/to/your/env/
```

### Github repository

Prior to running your job, ensure you update your git branch (`git pull; git checkout main`).
Do not make git requests within the SLURM script (no internet access).

### Running your job

On the Login or Transfer Nodes:

Run the job:
`sbatch my_job_name`

Check in on the job:
`squeue -l --me`

Check the output directory for your work:
`ls /output/location/path # something like $BIGWORK or $BIGWORK/my_output_dir`


## Creating & running a job (Training GR00t models for Kibub via Lerobot scripts)

1. Suppose your Huggingface dataset is saved either locally to your computer (`.cache/huggingface/lerobot/oliveoil8888/pick-up-cup`) or online at the Huggingface hub at tag `oliveoil8888/pick-up-cup`. 

2. You can update the Github: `cd $SOFTWARE/$USER/agent-kibub` and then `git pull; git submodule update`

3. Run `chmod a+x $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-*`

4. Edit the file `TrainKibub-VARS.sh` to modify the bash variables. You can either run `nano $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh` directly in the cluster Login Node shell, or edit TrainKibub-VARS.sh in a local agent-kibub repo, push those changes, and then pull those changes to the cluster Login Node. Avoid using VSCode SSH sessions on the cluster node (doing so is quite resource intensive). 

  An example of TrainKibub-VARS.sh:
  ```
  #!/bin/bash 

  #############################
  # Edit the variables below  #
  #############################
  # The DOWNLOAD, RUN, and UPLOAD scripts source this script automatically.

  # To simply set variables in the shell, run this script using `source` or `.`: 
  # Run `. TrainKibub-VARS.sh`. Do not run `./TrainKibub-VARS.sh`, as this script is a child process that cannot set variables in its parent.

  # dataset variables
  export DATASET_REPO="oliveoil8888/pick-up-cup" # hf tag of the Huggingface dataset you would like to download for training
  export TASK="Pick up the cube and place it in the cup." # language prompt demonstrated by the dataset

  # huggingface auth 
  export HF_USER="oliveoil8888" # your own huggingface usertag, for uploading to hf later

  # training variables
  export STEPS=50000
  export BATCH_SIZE=4
  export MODEL_REPO="pick-up-cup-model" #the name of your resulting model

  # SLURM directives
  export SLURM_TIME="00.05.00"

  # Edit no further! Only modify vars above. Do not edit the vars below! 
  ##########################################
  ##########################################
  ##########################################
  # Do not edit any of the variables below #
  ##########################################
  export OUTPUT_DIR="${BIGWORK}/lerobot-run/outputs/train/${POLICY}-${MODEL_REPO}"
  export HF_HOME=$BIGWORK/lerobot-run/.cache/huggingface
  export HF_LEROBOT_HOME=$HF_HOME/lerobot
  export POLICY="groot"     
  ```  

*WARNING*: The following steps export shell variables, which reset when you restart your terminal, and can be overwritten. If you run `REPO=pick-up-cup` but then run `REPO=wave-hello`, REPO will lose the original value `pick-up-cup`. If you want to run multiple jobs in succession (download job1, job2, then run job1, job2, then upload job1, job2) it would be simpler to copy and paste the job1 version or job2 version of TrainKibub-VARS.sh into the cluster file TrainKibub-VARS.sh before running the download, run, upload scripts. 

5. Run `$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-DOWNLOAD.sh`. This script runs your TrainKibub-VARS.sh to export your modified variables, and then downloads your desired dataset.

Example:
```
(lerobot) nhkwcaio@login02:/software/NHKW25031/nhkwcaio/agent-kibub/cluster$ ./TrainKibub-DOWNLOAD.sh 
Executing script TrainKibub-DOWNLOAD.sh
Module for Miniconda3, version 24.7.1-0 unloaded
Module for Miniconda3, version 24.7.1-0 loaded
DATASET_REPO oliveoil8888/pick-place-cube-cup-1
TASK Pick up the cube and place it in the cup.
STEPS 20
BATCH_SIZE 4
MODEL_REPO pick-up-cup-model
SLURM_TIME 00.05.00
OUTPUT_DIR /bigwork/nhkwcaio/lerobot-run/outputs/train/groot-pick-up-cup-model
HF_HOME: /bigwork/nhkwcaio/lerobot-run/.cache/huggingface
HF_LEROBOT_HOME: /bigwork/nhkwcaio/lerobot-run/.cache/huggingface/lerobot
User is already logged in. Use `hf auth login --force` to force re-login.
Request ...
Send ...
Downloading ...
...

# then after a bunch of logging...

Download complete. Moving file to /bigwork/nhkwcaio/lerobot-run/.cache/huggingface/hub/oliveoil8888/pick-place-cube-cup-1/videos/observation.images.wrist_left/chunk-000/file-000.mp4
Fetching 11 files: 100%|█| 11/11 [00:06<00:00,  1.82
Download complete: 100%|█| 394M/394M [00:06<00:00, 1✓ Downloaded
  path: /bigwork/nhkwcaio/lerobot-run/.cache/huggingface/hub/oliveoil8888/pick-place-cube-cup-1
Download complete: 100%|█| 394M/394M [00:06<00:00, 6
```

6. Run `mkdir -p $BIGWORK/lerobot-run; cd $BIGWORK/lerobot-run` 

7. Run `$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-RUN.sh`. This script, which will be queued and executed by SLURM, internally runs the command `sbatch <passes any SLURM directives> ./$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-RUN.sh`. This step assumes you have already ran TrainKibub-DOWNLOAD.sh, and then computes your job. 
 
Example:
```
5031/nhkwcaio/agent-kibub/cluster$ ./TrainKibub-RUN.sh 
Executing script TrainKibub-RUN.sh
DATASET_REPO oliveoil8888/pick-place-cube-cup-1
TASK Pick up the cube and place it in the cup.
STEPS 50000
BATCH_SIZE 4
MODEL_REPO pick-up-cup-model
SLURM_TIME 00:05:00
OUTPUT_DIR /bigwork/nhkwcaio/lerobot-run/outputs/train/groot-pick-up-cup-model
HF_HOME: /bigwork/nhkwcaio/lerobot-run/.cache/huggingface
HF_LEROBOT_HOME: /bigwork/nhkwcaio/lerobot-run/.cache/huggingface/lerobot
Sending job with sbatch now!
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: gpu
Submitted batch job 7492368
```

8. You can check on your job by running `squeue -l --me`; it will likely output something like:
```
      (lerobot) nhkwcaio@login02:/software/NHKW25031/nhkwcaio/agent-kibub/cluster$ squeue -l --me
Thu Jul 02 15:15:10 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
           7492368       gpu lerobot- nhkwcaio  PENDING       0:00      5:00      1 (Resources)

```

9. After your job has finished running (likely 5-8 hours later) you can retrieve the output models and the .out and .err files. Use your JOBID:
```
cd $BIGWORK/lerobot-run
echo "Check outputs of job ${JOB_ID}":
cat lerobot-train_${JOB_ID}.out
cat lerobot-train_${JOB_ID}.err

ls $OUTPUT_DIR 
```

10. Finally, you can upload your dataset to Huggingface. It is likely that you would close your terminal session in the many hours that the job would be running, so SSH back into the Login node and run `$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-UPLOAD.sh`

Example:
```
(lerobot) nhkwcaio@login02:/software/NHKW25031/nhkwcaio/agent-kibub/cluster$ ./TrainKibub-UPLOAD.sh 
Executing script TrainKibub-UPLOAD.sh
This script is used for uploading your trained model to Huggingface. Run this script on the Login node.
Ensure you are logged into Huggingface, and that you have exported REPO and POLICY beforehand.
Module for Miniforge3, version 25.3.0-3 unloaded
Module for Miniforge3, version 25.3.0-3 loaded
User is already logged in. Use `hf auth login --force` to force re-login.
HF_USER oliveoil8888
DATASET_REPO oliveoil8888/pick-place-cube-cup-1
TASK Pick up the cube and place it in the cup.
HF_USER oliveoil8888
STEPS 50000
BATCH_SIZE 4
MODEL_REPO pick-up-cup-jun28-1
SLURM_TIME 08.00.00
OUTPUT_DIR /bigwork/nhkwcaio/lerobot-run/outputs/train/groot-pick-up-cup-jun28-1
Start hashing 12 files.
Finished hashing 12 files.
Processing Files (5 / 5)      : 100%|█| 9.72GB / 9.7
New Data Upload               : 100%|█| 5.07GB / 5.0
  ...timizer_state.safetensors: 100%|█| 4.28GB / 4.2
  ...d_model/model.safetensors: 100%|█| 5.45GB / 5.4
  ...ate/rng_state.safetensors: 100%|█| 15.7kB / 15.
  ...ack_inputs_v3.safetensors: 100%|█| 11.9kB / 11.
  ...nnormalize_v1.safetensors: 100%|█| 11.9kB / 11.
✓ Uploaded
  url: https://huggingface.co/oliveoil8888/pick-up-cup-jun28-1/commit/aa596fc3f9f9b6790a23b0d2ef49d40265bbd544
Finished uploading the model to Huggingface.
```

## Cleaning up

If you no longer need to use a dataset, then clean up your storage. Below is the list of *what* is being stored *where*:

stuff | dir path | when to delete the stuff | how to delete
--- | --- | -------- | --- | 
.out/.err job files | $BIGWORK/lerobot-run/ | anytime after job finishes; logging from slurm | `rm *.out *.err` |
trained models | $BIGWORK/lerobot-run/outputs/train | after uploading model to hf | `rm -r <dir path>/<model_name>` |
recorded demonstration datasets | $BIGWORK/lerobot-run/.cache/huggingface/lerobot | after model finishes training | `rm -r <dir path>/<dataset_name>` |
groot base model | $BIGWORK/lerobot-run/.cache/huggingface/hub/models--nvidia--GR00T-N1.5-3B | do not delete otherwise cannot train groot | `rm <dir_path>` | 
eagle base model | $BIGWORK/lerobot-run/.cache/huggingface/lerobot/lerobot/eagle2hg-processor-groot-n1p5 | do not delete otherwise cannot train groot | `rm <dir_path>` | 
virtual env | $SOFTWARE/$USER/envs/ | do not delete unless project is over | `conda env remove -p $SOFTWARE/$USER/envs/<env_name>`
