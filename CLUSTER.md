# Computing Cluster Notes

Notes from reading the LUIS HPC Cluster Documentation https://docs.cluster.uni-hannover.de/doku.php/start 

## Prerequisites:
- username and password
- LUH network connection or VPN/tailscale connection

## Connecting to the cluster

You can use SSH, X2Go, or web browser. I personally don't want to download a GUI, so I'm going to use SSH and the web browser.

SSH:
- `ssh ${CLUSTERUSER}@login.cluster.uni-hannover.de`

web browser  (firefox):
- https://login.cluster.uni-hannover.de/auth/login.html 

## File systems in the cluster

File systems serving the cluster are mounted as subdirectories 

BIGWORK
- working dir - the kitchen
- computations done here
- connected via the InfiniBand network interface (faster than HOME)
- use for multi-core jobs but for many small files, prefer TMPDIR
- ALL nodes in the cluster are mounted to the SAME BIGWORK 

PROJECT
- each proj gets a dir at `/project/cluster_groupname`
- TODO: `mkdir -m 0700 ${PROJECT}/${USER}`
- this dir isnt for working, so its only mounted on login and not compute nodes (think of it like the front entrance of an apartment--you can see the mailbox of who lives here, but no cooking/working goes on over here)
- if you want to cook a meal and leave it for your apartment neighbour (colleague in your PROJECT), you would cook it inside the kitchen (in BIGWORK) and then from login mount bring it out into the apartment entrance (into PROJECT)

HOME
- very slow, not for data intensive tasks
- quote: "you should only place important and small files in your $HOME that would be particularly difficult and laborious to re-create (like configs etc.), but meticulously avoid accesssing data here from within compute jobs"
- IMPORTANT: Do NOT place pip, (ana)conda, CRAN/R or similar installations here (instead put this in SOFTWARE)
- HOME is mounted on all nodes in the cluster

TMPDIR
- local storage to each node
- good for many very small files
- BIGWORK would need to pack datasets with millions of files into tarballs and locally extract them on the fast SSD scratch disk prior to job start: `tar -cf <archive_file.tar> <directory_to_archive> ; cd $TMPDIR ; tar -xf $BIGWORK/archive_file.tar`
- IMPORTANT since TMPDIR is local to each node, if task occupies two diff nodes, tasks on each node see a diff local dir
- check size of TMPDIr first: `scontrol show nodes <nodename_here>` or `df -h $TMPDIR` parameter “TmpDisk” shows you the configured size of the scratch/$TMPDIR partition in MiB
- Dumbo: TMPDIR is 16 TB of mechanical HDD
- other nodes have around 100 GB local storage
- IMPORTANT NOTE: when job finihs, all data stored under TMPDIR auto delete

SOFTWARE
- install pip conda etc here
- `mkdir -m 0700 $SOFTWARE/mysoft`
- group quota 50 GB
- can use access control list (ACL) to grant user specific access

QUOTA and GRACE TIME
- during grace time, can exceed soft quota up until hit hard quota. when grace timer over, cannot add NEW data (but whatever alr on disk stays on disk)
- check four letter code and five digit number via `id`
- For $BIGWORK, $PROJECT and $SOFTWARE, the relevant (user/group) block and inode quota grace times are 30 days. On $HOME, grace time is 10 days
- `checkquota` query disk space usage and quota

LUSTRE FILE SYSTEM AND STRIPE COUNT
- BIGWORK and PROJECT: usually work well without changing default vals, but  for files >1GB OR access diff parts of same file in highly parallel apps on several nodes --> can change STRIP COUNT
- data on Lustre based file sys os saved on OST (object storage targets)
- location of OST is registered with dir server (MDS) and stored on MDT (meta data target)
- define STRIPE COUNT (int, -1==all available OSTs): how many OSTs used to store data --> splitting over multiple can incr speeds (incr parallel threads). do this for LARGE files, not efficient for too many SMALL reqs. 
- file > 1GB: set strip count manually (check cluster_doc.pdf page 22/141)
- It is advised to create a directory below $BIGWORK and set a stipe count of -1 for it ==> use for store all files >100MB.
- for files sig small <100, stripe count = 1 is better + sufficient

## Handling large datasets within the cluster


> mpi run --> can use dcp, drm, dfind, dsync, dtar, dbz2, dstripe, dwalk, ddup: read more here http://mpifileutils.readthedocs.io/ 
- mpiFileUtils ==> parallel tools (since Unix cp rm find are single threaded)
- quickfix for free space in BIGWORK: copy files from BIGWORk to PROJECT, del from BIGWORK
- `dsync`
- speed up the recursive transfer of the contents of the directory $BIGWORK/source to $TMPDIR/dest on a compute node, put the lines below in your job script or enter them at the command prompt of your interactive job - we assume that you've requested 8 cores for your batch job: `module load GCC/8.3.0 OpenMPI/3.1.4 mpifileutils/0.11; mpirun -np 8 dcp $BIGWORK/source/ $TMPDIR/dest`
- command mpirun launches dcp (distributed copy) in parallel with 8 MPI processes 
- directory $BIGWORK/dir and its contents can be removed quickly using the drm (distributed remove) command: `mpirun -np 8 drm $BIGWORK/dir` (command drm supports the option --match allowing to delete files selectively. See man drm)
- find all files on $BIGWORK larger than 1GB and write them to a file: `mpirun -np 8 dfind -v --output files_1GB.txt --size +1GB $BIGWORK` (man dfind, for more details)
- synchronize content, ownership, timestamp, permissions of the directory $BIGWORK/source to $PROJECT/dest: `mpirun -np 8 dsync -D $BIGWORK/source $PROJECT/dest` (launch dsync on login node)
- compressed archive mydir.tar.dbz2 of the directory mydir: `mpirun -np 8 dtar -c -f mydir.tar mydir; mpirun -np 8 dbz2 -z mydir.tar`

## File transfer to/from the cluster
- use dedicated transfer node **transfer.cluster.uni-hannover.de** so that your process of 30 min cpu time doesnt get killed
- use scp over ssh for transfer: `[myworkstation]$ scp -r <username>@transfer.cluster.uni-hannover.de:/path/to/mydata .`
- or use the demanding but powerful rsync: `[myworkstation]$ rsync -av --delete /path/to/mydir/ <username>@transfer.cluster.uni-hannover.de:/bigwork/<username>/mydir/`
- i dont care to use filezilla or a gui for file trasnfer (command line for life)

TO ENSURE YOUR FILES ARE REALLY IDENTICAL
- `sha256sum <file-to-check>`

TRANSFERRING FILES FROM /TO CLOUD STORAGE
- cmdline prog Rclone to sync files bn cluster (compute and login node) and ext cloud storage systems (like dropbox, google drive, etc) but LUIS uses Seafile
- Rclone has cloud equiv cmds ls, cp, mkdir, rm, rsync, etc
- if migrate large data use transfer node of cluster
- configured your LUIS “Cloud-Seafile” storage for access via WebDAV: https://www.luis.uni-hannover.de/en/services/storage-systems/dateiservice/services/speichersysteme/dateiservice/translate-to-english-cloud-dienste/seafile#c18483 
- check cluster_doc.pdf page 36/141 for user login and more cloud stuff
- can use cron with Rclone 

TRANSFERRING DATA INTO THE ARCHIVE
- dont need this for now, skipping this section

## SLURM USAGE GUIDE

PARALLELIZATION

batch jobs
- **serial**: no scaling achieved, serial program on larger machine (which has lots of smaller cpu cores on one cpu socket) actually can run slower because the total heat generated by the lots of smaller chips needs to dissipate
- **parallel**: trivially parellel if each job achieves a partial result and then is combined with all other results (like matrix multiplciation) but nontrivial: need to exchange data DURING comptation

how to parallel job:
- **openmp** - shared memory processing run on one node only using mult threads but sharing memory --> easy low effort parallilzation, linked to openmp lib during compilation, so node itself needs to have some libs installed. careful a specific memroy loc is only accesed by one proc at a time
- **mpi** message passing interface, can scale up to millions of cpus: highest scaling but cost is that sw must explicitly specifiy wchih parts of prog run in parallel and how data/res are updated, which parts does what, etc. each MPI task (called a "rank") is highly independent and needs to explicityyl communciate results since each task ues their own mem that they only access

SLURM workload manager
- Simple Linux Utility for Resource Management decides which job run when and where in cluster
- cmds: sbatch, salloc, srun, squeue, scancel, sinfo, scontrol, sacct, slurmtop https://slurm.schedmd.com/man_index.html 

PARTITIONS
- compute nodes w similar HW attr (like same cpu etc) in cluster are grouped in partitions 
- partitions are indep of others
- batch job can be submitted to one of several partitions
- compute node may belong to several paritions simult to faciliate selection
- **job steps** --> used to exec several tasks simult or sequent w/in a job using `srun`
- schedular auto adjusts resource requests if u request more mem per core to ensure avoiding nodes w no mem but some cores left unuseable
- check how much mem allocateable per code: `scontrol show partition <partitionname>` look for MaxMemPerNode= param

suppose you req a job using 4 cores and 40 GB on amo.
amo has default 4000 MB mem per cpu, 5120 max. so, 40 GB == 40 000 MB, then 40 000 total MB / 5120 max MB per core = 7.8125 amo partition cores needed, which means auto readjust to use 8 core instead of 4 core

MPP subcluster
- 37 cmput nodes with AMD EPYC procs --> each prov 128 CPU cores, 500 GB RAM. new components avail in mpp.single and mpp.share
- mpp.single has nodes for exclusive usage: jobs submitted will auto alloc entire cmput nodes. NO OTHER JOB will share same jode while ur job is running -> this reduces performance losses 
- avoids inefficiencies caused by fragmentation
- mpp.single partition for workloads that can efficiently utilize full resources of a node (DONT SUBMIT JOBS THAT DONT SCALE TO FULL NODE like single core or low mem)
- jobs are NOT auto assgn to mpp.single --> to use this partition, explicitly request in job submission (either in job script or cmdline for interactive jobs using `--partition=mpp.single`) a single user can req up to 4 nodes in mpp.single
- currently 10 cmput nodes assgn to mpp.single partition
- mpp.share parition --> mult jobs and users can run simult on same node 
- UNLIKE other parititons, mpp.single and mpp.share have max job runtime of 48 hr

COMPUTE NODE NAMING CONVENTION
- read doc page 47/141 of cluster_doc

List jobs relevant for you:
`sacctmgr -s show user; sacctmgr -s show user format=user,account,maxjobs,maxsubmit,maxwall,qos`

Up to date info on all avail nodes:
`sinfo -Nl; scontrol show nodes`

info on partitions and their config:
`sinfo -s; scontrol show partitions`

config slurm limits display:
`clusterinfo -l`

help:
`clusterinfo -h`

INTERACTIVE JOBS
- use for working with interactive terminal or GUI or SW dev, debugging, compiling
- start interactive session on cmput node: `salloc`
- define interactive job:a method where you request compute resources (CPUs, memory, GPUs) and immediately log into the allocated compute node(s) to run commands and debug software in real time. this is unlike styandard batch proc, where submit script to queue to run. Unlike batch jobs (sbatch), interactive jobs terminate immediately if your connection to the cluster drops
- --ntasks == "num of indep MPI ranks" while --cores-per-task == "num of OpenMP threads"
- MPI-jobs usually request --ntasks > 1, while OpenMP-jobs may request --ntasks=1 and --cores-per-task > 1

SUBMITTING BATCH SCRIPTS
- define batch script: shell script with set of additional directives interpreted by SLURM. directives marked by #SBATCH
- find valid directives at `man sbatch`
- --mem=0 gets access to the complete memory configured in SLURM for each ndoe allocd
-  use the srun command instead of mpirun or mpiexec

```
$SLURM_JOB_ID Job id
$SLURM_JOB_NUM_NODE Number of nodes assigned to the job
$SLURM_JOB_NODELIST List of nodes assigned to the job
$SLURM_NTASKS Number of tasks in the job
$SLURM_NTASKS_PER_CORE Number of tasks per allocated CPU
$SLURM_NTASKS_PER_NODE Number of tasks per assigned node
$SLURM_CPUS_PER_TASK Number of CPUs per task
$SLURM_CPUS_ON_NODE Number of CPUs per assigned node
$SLURM_SUBMIT_DIR Directory the job was submitted from
$SLURM_ARRAY_JOB_ID Job id for the array
$SLURM_ARRAY_TASK_ID Job array index value
$SLURM_ARRAY_TASK_COUNT Number of jobs in a job array
$SLURM_GPUS Number of GPUs requested
```

GPU JOBS ON THE CLUSTER

- 4 nodes equipped with 2× NVIDIA Tesla V100 GPUs each (named gpu-20-n0xx),
- 3 nodes equipped with 4× NVIDIA A100 GPUs each (named gpu-22-n0xx),
- 4 nodes equipped with 4× NVIDIA H200 GPUs each (named gpu-25-n0xx).

- disp access rights to parttns w GPUs: `clusterinfo -vv`

- To ask for GPU resources, you need to add the directive `#SBATCH --gres=gpu:<type>:n`


## Modules and Application Software 

Run `spider` to see list of available software & dont go rogue trying to get a diff version of alr installed apps

- Abaqus
- ANSYS / CFX
- Code-Server (VS Code) on LUIS Cluster
- COMSOL
- Conda
- CPMD
- FEKO
- Jupyter on LUIS Cluster
- MATLAB
- mpiFileUtils
- NFFT
- uv – Python package manager

*Below I will write notes only on the modules I believe I need:*

CODE SERVER

To start a VS Code session, navigate to the Open OnDemand dashboard (login here https://login.cluster.uni-hannover.de/)  and select Interactive
Apps → Code-Server from the top menu. Complete the form by specifying the working directory,
walltime, memory, CPUs, GPUs, and partition. The default values shown in the form will be used if left
unchanged. Click Launch to start the session.

- IMPORTANT: always start Code-Server via Open OnDemand to ensure VSCode backend runs inside scheduled SLURM job on cmput node while u interact w editor thru web browser
- save work frequently

JUPYTER ON LUIS CLUSTER
- available from within cluster web portal 
- login thru portal, Ineractive Apps, Jupyter --> select conda and module envs from the dropdown Standard env list
- OOD Jupyter apps currently launhc on a SINGLE compute node

Creating custom jupyter kernels:
1. create and populate env using `ipykernel`
2. install custom python kernel for jpyterlab, loc in subdir of $HOME/.local/share/jupyter/kernels
NOTE: this has to be done on login node bc installing python packages needs acess to internet

Conda env --> steps to make conda env avail in jupyterlab sess:

1. create conva env
```
[username@login01 ~]$ module load Miniforge3
[username@login01 ~]$ conda create -n my_env
```
2. activate env, install ipykernel lib, create python kernel for jupyterlab:
```
[username@login01 ~]$ conda activate my_env
(my_env)[username@login01 ~]$ conda install ipykernel
(my_env)[username@login01 ~]$ make-ipykernel --name my_conda_env --display-
name "My Software Env"
```
The configuration file, kernel.json, of the my_conda_env kernel will be created in the directory
$HOME/.local/share/jupyter/kernels/my_conda_env.

The --name option must uniquely identify the kernel
3. install aditional packages in the env:
```
(my_env)[username@login01 ~]$ conda install numpy matplotlib sympy
```

swtich kernels using menu  Kernel --> Change Kernel

CONDA 
