# Cluster Computing Intro

Created by: Olivia Cai
Date: June 25 2026 - June 30 2026

*Table of Contents:*
1. "Explain Like I'm Five" for Cluster Computing
2. Cluster computing jargon definitions
3. Cluster computing job types
4. Setting up your cluster workspace (General + Training GR00t models for Kibub via Lerobot scripts)
5. Creating & running a job (General + Training GR00t models for Kibub via Lerobot scripts)

## "Explain Like I'm Five" for Cluster Computing

There exists a huge kitchen with a bunch of microwaves, ovens, stovetops, and more.
This kitchen is capable of cooking multiple meals at once.

This kitchen is shared between multiple families (projects). Imagine what would happen if there were no rules in this kitchen (cluster): ingredients (datasets) and recipes (programs) would be left out, taking up counter space (GB of storage). You could steal someone else's ingredients, remove someone's meal from the stovetop to cook your own food (kill a process to free up a CPU for your own job), or impatiently watch as someone uses the largest microwave to heat up a tiny breadroll--even though the smaller microwaves were available! 

Cluster computing is a way to efficiently organize users in a kitchen:
- Users need to specify the duration and resources they'll need for their project in advance. Violating this time results in your half-cooked food being removed from the stovetop for the next pot.
- If the kitchen is busy, you have to wait in queue, where your request is evaluated automatically based on the resources and time you specify.
- The kitchen is for cooking, not storage; if you have a surplus of 500 kg of potatoes, you'll have to store it at home (local) or in your family's storage space (the designated storage space of your project). 

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

# Setting up your cluster workspace

## Initial Setup (General)

*General setup for organizing your workspace. The following instructions are intentionally vague to act as a general guide. For specific instructions on training Groot VLA models on Kibub, Ctrl+F for "Training GR00t models for Kibub via Lerobot scripts".*

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

4. Create your workspaces in $PROJECT and $SOFTWARE:
```
mkdir -m 0700 ${PROJECT}/${USER}
mkdir -m 0700 ${SOFTWARE}/${USER}
```
You can double check the existence of your newly created directories by running `ls $PROJECT` or `ls $SOFTWARE`.

5. Clone agent-kibub into `${SOFTWARE}/${USER}` by running the following: `cd ${SOFTWARE}/${USER} ; git clone https://github.com/olivecai/agent-kibub.git`. (agent-kibub is the master repository for all repositories needed to control, train, and evaluate both VLAs and the OpenClaw agent on Kibub)

6. Initialize/update the git submodules:
```
cd agent-kibub
git submodule init
git submodule update
```

7. Create a conda env with python 3.12: `conda create --prefix $SOFTWARE/$USER/envs/lerobot python=3.12 -y`

Output example after a few minutes:
```
... #this process does take a bit of time...

# To activate this environment, use                             
#                                                               
#     $ conda activate /software/NHKW25031/nhkwcaio/envs/lerobot
#                                                               
# To deactivate an active environment, use                      
#                                                               
#     $ conda deactivate  
```

8. Activate the environment: `conda activate ${SOFTWARE}/${USER}/envs/lerobot`

7. Run `module load cuDNN/9.5.0.50-CUDA-12.6.0`:
Module for CUDA, version 12.6.0 loaded
Module for cuDNN, version 9.5.0.50-CUDA-12.6.0 loaded

8. Run `export CUDA_HOME=$EBROOTCUDA`

7. Run the following commands **in order**. Flash-attn is compiled against pre-existing packages and can be finicky to install, so it is imperative to install torch first!
```
# 1. torch (need to install torch first so that flash-attn build can see it)
pip install torch==2.7.1

# 2. lerobot editable (install from within the forked lerobot submod in agent-kibub/)
cd ${SOFTWARE}/${USER}/agent-kibub
pip install -e .

# 3. flash-attn (if this step fails, ensure you have loaded CUDA modules, exported CUDA_HOME, installed torch, and use --no-build-isolation flag)
pip install flash_attn==2.8.3 --no-build-isolation

# 4. the rest of the frozen requirements 
pip install -r ${SOFTWARE}/${USER}/agent-kibub/cluster/requirements-cluster.txt
```

8. Download GR00t and Eagle base models; finetuning your policies requires these base models to be locally downloaded for the Computing Node to access during the job:
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

## Finished!

You are now ready to train GR00t policies (& more) on the cluster!

# Creating & running a job

## Creating & running a job (General)

*Also see Creating & running a job (Training GR00t models for Kibub via Lerobot scripts)*

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

2. Edit the file `TrainKibub-VARS.sh` to modify the bash variables. You can either run `nano $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-VARS.sh` directly in the cluster Login Node shell, or edit TrainKibub-VARS.sh in a local agent-kibub repo, push those changes, and then pull those changes to the cluster Login Node. Avoid using VSCode SSH sessions on the cluster node (doing so is quite resource intensive). 

  An example of TrainKibub-VARS.sh:
  ```
  #!/bin/bash

  # All variables in this file must be set by the user.

  # dataset variables
  export DATASET_REPO="oliveoil8888/pick-up-the-cup" # hf tag of the Huggingface dataset you would like to download for training
  export TASK="Pick up the cup" # language prompt demonstrated by the dataset

  # huggingface auth 
  export HF_USER="oliveoil8888" # your huggingface usertag 

  # training variables
  export STEPS=50000
  export BATCH_SIZE=4
  export MODEL_REPO="pick-up-cup-model" #the name of your resulting model
  ```  

*WARNING: The following steps export shell variables, which reset when you restart your terminal, and can be overwritten. If you run `REPO=pick-up-cup` but then run `REPO=wave-hello`, REPO will lose the original value `pick-up-cup`.*

3. Run `./$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-DOWNLOAD.sh`. This script runs your TrainKibub-VARS.sh to export your modified variables, and then downloads your desired dataset.

4. Run ` sbatch $SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-RUN.sh`. This script, which will be queued and executed by SLURM, runs your TrainKibub-VARS.sh to export your modified variables, assumes you have already ran TrainKibub-DOWNLOAD.sh, and then computes your job. 

5. You can check on your job by running `squeue - l --me`; it will likely output something like:
```
      squeue -l --me
      Sun Jun 28 21:18:02 2026
              JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
            7479697       gpu lerobot- nhkwcaio  RUNNING       0:07   8:00:00      1 gpu-22-n009
```

6. After your job has finished running (likely 5-8 hours later) you can retrieve the output models and the .out and .err files. Use your JOBID:
```
cat lerobot-train_${JOB_ID}.out
cat lerobot-train_${JOB_ID}.err

ls ${BIGWORK}/lerobot-run/outputs/train/${HF_USER}/${POLICY}/${MODEL_REPO}
```
7. Finally, you can upload your dataset to Huggingface by running `./$SOFTWARE/$USER/agent-kibub/cluster/TrainKibub-UPLOAD.sh`

