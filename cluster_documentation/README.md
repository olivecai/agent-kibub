# Cluster Computing Intro

Created by: Olivia Cai
Date: June 25 2026

Table of Contents:
1. What is cluster computing?
2. Cluster computing examples
3. Initial workspace setup
4. Job lifecycle
5. Application to machine learning

## "Explain Like I'm Five" for Cluster Computing:

Imagine a huge kitchen with a bunch of microwaves, ovens, stovetops, and more.
This kitchen is capable of cooking multiple meals at once.

This kitchen is shared between multiple families (projects). Imagine what would happen if there were no rules in this kitchen (cluster): ingredients (datasets) and recipes (programs) would be left out, taking up counter space (GB of storage). You could steal someone else's ingredients, remove someone's meal from the stovetop to cook your own food (kill a process to free up a CPU for your own job), or impatiently watch as someone uses the largest microwave to heat up a tiny breadroll--even though the smaller microwaves were available! 

Cluster computing is a way to efficiently organize users in a kitchen:
- Users need to specify the duration and resources they'll need for their project in advance. Violating this time results in your half-cooked food being removed from the stovetop for the next pot.
- If the kitchen is busy, you have to wait in queue, where your request is evaluated automatically based on the resources and time you specify.
- The kitchen is for cooking, not storage; if you have a surplus of 500 kg of potatoes, you'll have to store it at home (local) or in your family's storage space (the designated storage space of your project). 

## A simple starter

Suppose you have two computers; one with a lot of storage space (we can call this the Storage Node), and the other with a lot of computing power (we can call this the Computing Node). Ideally, you could store data on Storage Node and run your computations on Computing Node. 

You brainstorm a simple workflow:
1. Data files are stored in Storage Node.
2. Somehow transfer files from Storage to Computing Node.
3. Computing Node runs your program and saves the output somewhere.
4. Storage Node retrieves the output from Computing Node.

Your friend likes your setup, and wants to use it too.

How can you fairly manage two users to the system? 

Your workflow now has two important updates:
1. There exists an automation running on Computing Node that follows a general rule:
    "When Computing Node receives a job, first check if the CPU is busy working on a different job and queue the jobs accordingly."
2. Storage Node will contain a folder for yourself ("/home/storage/MyProject"), and for your friend ("/home/storage/MyProjectYourProject"). 

Now that you have your automated queuing system, jobs can be submitted whenever and Computing Node takes care of the rest. Suppose Computing Node is currently busy with a job, and your friend submits an 8 hour job. A minute later, you submit three jobs which each take 1 minute to run.

In cluster computing, your jobs would be prioritized over your friend's job; priority is *not* first-come-first-serve, but based on resources and time.

Imagine you submit three jobs which each take 5 minutes to compute. 

To do so, you need to consider a few important factors:
1. How will your Storage and Computing Node communicate? Consider that a serial USB connection can only transmit up to TODO bits/s, ethernet is TODO, and other methods like TODO
2. 

You have a few different consideroptions in managing your data:
1. Connect Storage and Computing Node through

# Running jobs on the cluster

## Initial Setup (General)

*General setup for organizing your workspace. The following instructions are intentionally vague to act as a general guide. For specific instructions on training Groot VLA models on Kibub, Ctrl+F for "Setup for Training Groot VLA models on Kibub".*

1. Obtain your LUIS cluster username and password, $USER and $PASSWORD
2. SSH into the Login Node: `ssh ${USER}@transfer.cluster.uni-hannover.de`;
2. Create your cluster workspaces in $PROJECT and $SOFTWARE:
    ```
    mkdir -m 0700 $PROJECT/$USER
    mkdir -m 0700 $SOFTWARE/$USER
    ```
    You can double check the existence of your newly created directories by running `ls $PROJECT` or `ls $SOFTWARE`. 
1. Prepare your inputs; data, script, environment.
    data: input dataset
    script: a bash script that contains SLURM directives and more
    environment: a virtual environment 
2. Use the Transfer Node to transfer inputs from client local to the cluster:`scp location/to/local/inputs $USER@transfer.cluster.uni-hannover.de:$PROJECT/$USER`
3. SSH into the Login Node: `ssh $USER@login.cluster.uni-hannover.de`
4. If you would like to use conda environments: load Miniconda and then create a conda env located in your $SOFTWARE/$USER folder: `module load Miniconda3; conda create --prefix $SOFTWARE/$USER/environments/my_env`
6. Clone necessary Github repositories: `cd $SOFTWARE/$USER; git clone repository_url`
7. Install necessary packages into your environment. If you have a requirements.txt, you can run: `conda activate my_env; pip install -r requirements.txt`. To generate a requirements.txt of a pre-existing local env: on your local computer, activate the environment you would like to replicate and run `pip freeze > requirements.txt`. Then run `scp requirements.txt $USER@transfer.cluster.uni-hannover.de:$SOFTWARE/$USER`.
8. You have finished the initial setup. Depending on your application, you will likely need to load other modules or export shell variables. In your future SLURM scripts, don't forget to include the line `module load X` for each module you use, including `Miniconda3`. 




## Preparing Inputs

### Data

There will be no changes to the format of your dataset.

### Script Directives 

Refer to the LUIS documentation for details on directives or CLUSTER_EXAMPLES.md for a list of important examples from the documentation.

A quick description and cheatsheet is provided below:

**Serial**: 1 process on 1 core on 1 node. Use this for programs that have no parallelism built in, or as a baseline before optimizing. 

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


### Environment

If you already have a conda environment:
1. Obtain the environment packages via pip freeze: `pip freeze > requirements.txt`

### You should now have the following files:
1. Dataset (unchanged)
2. Python program (unchanged)
3. Bash script containing SLURM directives (newly created)
4. requirements.txt (newly created)

# General Cluster User Setup

The following instructions are intentionally vague to act as a general guide. For specific instructions on training Groot VLA models on Kibub, Ctrl+F for "Setup for Training Groot VLA models on Kibub".

1. Let USER be your cluster username; SSH into the cluster Login Node: `ssh ${USER}@transfer.cluster.uni-hannover.de`.

2. Create your workspaces in $PROJECT and $SOFTWARE:
```
mkdir -m 0700 $PROJECT/$USER
mkdir -m 0700 $SOFTWARE/$USER
```
You can double check the existence of your newly created directories by running `ls $PROJECT` or `ls $SOFTWARE`. 

3. It is important to note that the Computing nodes do not have access to internet or $PROJECT; therefore, you should download tools/pretrained models into $SOFTWARE/$USER, and datasets into $BIGWORK. (For example, if you plan to finetune a policy on the base Huggingface GR00t model, you will need to download the base models from Huggingface and edit your training script to search for the locally cached model, not through the Huggingface hub.)

# Setup for Training Groot VLA models on Kibub 

The following instructions are specifically created for training Groot VLA models on Kibub on June 26 2026,
and also serve as a detailed example if you would like to use conda environments. 

## Local Client Setup

1. agent-kibub is the master repository for all repositories needed to control, train, and evaluate both VLAs and the OpenClaw agent on Kibub. Clone the repository agent-kibub if you haven't already: `git clone https://github.com/olivecai/agent-kibub.git` (https) or `git clone git@github.com:olivecai/agent-kibub.git` (ssh).

2. Initialize/update the git submodules:
```
cd agent-kibub
git submodule init
git submodule update
```

3. Let USER be your cluster username; SSH into the cluster Login Node: `ssh ${USER}@transfer.cluster.uni-hannover.de`.

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

5. Clone agent-kibub into `${SOFTWARE}/${USER}` by running the following: `cd ${SOFTWARE}/${USER} ; git clone https://github.com/olivecai/agent-kibub.git`

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

# 2. lerobot editable
pip install -e .

# 3. flash-attn (if this step fails, ensure you have loaded CUDA modules, exported CUDA_HOME, installed torch, and use --no-build-isolation flag)
pip install flash_attn==2.8.3 --no-build-isolation

# 4. the rest of the frozen requirements 
pip install -r ${SOFTWARE}/${USER}/agent-kibub/requirements-cluster.txt
```

## Finished!

You are now ready to train GR00t policies (& more) on the cluster!