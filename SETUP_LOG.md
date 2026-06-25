(base) ocai@cowmatch005:~$ ssh nhkwcaio@login.cluster.uni-hannover.de
The authenticity of host 'login.cluster.uni-hannover.de (130.75.7.130)' can't be established.
ED25519 key fingerprint is SHA256:sG8ZYabQctyGjxPD7X8K2IBxJIE5xHHZ9mQqjlVcjxo.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'login.cluster.uni-hannover.de' (ED25519) to the list of known hosts.
(nhkwcaio@login.cluster.uni-hannover.de) Password: 
************************************************************************************
*                                                                                  *
*                Welcome to the LUIS Scientific Computing Cluster                  *
*                                                                                  *
*  - Email cluster-help@luis.uni-hannover.de with questions or to report problems  *
*                                                                                  *
*  - Documentation and next cluster introductory course                            *
*         https://docs.cluster.uni-hannover.de                                     *
*            -> Cluster introductory course                                        *
*                                                                                  *
*  - General service description and formal requirements for cluster usage         *
*         https://www.luis.uni-hannover.de/scientific_computing_doku.html          *
*                                                                                  *
*                                                                                  *
*   Useful commands:                                                               *
*                                                                                  *
*     clusterinfo           - show cluster resources, your access rights, etc.     *
*     module --all spider   - list available (including hidden) software modules   *
*     squeue -l --me        - check status of your running and pending jobs        *
*     slurmtop -u $USER     - monitor your jobs and cluster nodes                  *
*     reportseff <job-id>   - show efficiency (CPU, Memory) of your finished jobs  *
*     checkquota            - check your disk(HOME|BIGWORK|PROJECT) quota          *
*                                                                                  *
*                                                                                  *
*   Please do not use HOME as your working directory. Use BIGWORK instead          * 
*                                                                                  *
*   Do not run your production programs on the login nodes. They will be           *
*   terminated without notice after a maximum run time of 30 minutes               *
*                                                                                  *
************************************************************************************

nhkwcaio@login03:~$ clusterinfo
Partition    Node List                                              Provider    Default Time    Max Time    AccessPolicy of nhkwcaio
-----------  -----------------------------------------------------  ----------  --------------  ----------  -------------------------------
amo          amo-n[001-080]                                         LUIS        1-00:00:00      8-08:00:00  Unrestricted
gpu.test     gpu-18-n012                                            LUIS        01:00:00        03:00:00    Unrestricted
gpu          gpu-20-n[005-008],gpu-22-n[009-011],gpu-25-n[001-004]  LUIS        01:00:00        2-00:00:00  Unrestricted
haku         haku-n[001-020]                                        LUIS        1-00:00:00      8-08:00:00  Unrestricted
jhub         jhub-n[005,010]                                        LUIS        01:00:00        2-00:00:00  Unrestricted
lena         lena-n[001-080]                                        LUIS        1-00:00:00      8-08:00:00  Unrestricted
mpp.single   mpp-25-n[001-010]                                      LUIS        01:00:00        2-00:00:00  Unrestricted
mpp.share    mpp-25-n[011-037]                                      LUIS        01:00:00        2-00:00:00  Unrestricted
smp          smp-23-n[010-011],smp-25-n[001-009]                    LUIS        12:00:00        8-08:00:00  Unrestricted
taurus       taurus-n[001-024]                                      LUIS        1-00:00:00      8-08:00:00  Unrestricted
vis          vis-n001                                               LUIS        01:00:00        03:00:00    Unrestricted
ai           ai-n[001-002,005-008]                                  FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
ainlp        ai-n[003-004]                                          FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
                                                                                                            Unrestricted
ai.h100      ai-n009                                                FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
ai.b300      ai-n[010-011]                                          FCH         01:00:00        8-08:00:00  Denied (09:02:50 - 20:00:00)
enos         enos-n[001-032]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
                                                                                                            Denied (10:30:00 - 11:30:00)
fi           fi-n001                                                FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
gih          gih-n002                                               FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imes.gpu     imes-n001                                              FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imes         imes-n002                                              FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imuk         imuk-n[001-009]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
isd          isd-n[002-011]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
isu          isu-n[004-009]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
itp          itp-n[005-011]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
iwes         iwes-n[001-002]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
p4d          p4d-n[001-003]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
pcikoe       pcikoe-n[001-017]                                      FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
phd          phd-n[001-032]                                         FCH         1-00:00:00      8-08:00:00  Exclusive (08:00:00 - 20:00:00)
phdgpu       phdgpu-n001                                            FCH         1-00:00:00      8-08:00:00  Exclusive (08:00:00 - 20:00:00)
stahl        stahl-n[001-003]                                       FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
tnt          tnt-n[003,005-006]                                     FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)

Use -i or --column-info to display column descriptions
Use -v for verbose output, -vv for more details

nhkwcaio@login03:~$ squeue -l --me 
Thu Jun 25 10:07:48 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)


nhkwcaio@login03:~$ ls
web-login

nhkwcaio@login03:~$ pwd
/home/nhkwcaio
nhkwcaio@login03:~$ cd $BIGWORK
nhkwcaio@login03:/bigwork/nhkwcaio$ cd $PROJECT
nhkwcaio@login03:/project/NHKW25031$ ls
'Binary Robotic'   Ince_project   match-DigitalTools   MT_Nablax   nhkwdepk   nhkwdepk_BigWorkOld   nhkwhany   nhkwkhai   nhkwleal   nhkwroma   nhkwroma_BigWorkOld   nhkwschl   nhkwwend
nhkwcaio@login03:/project/NHKW25031$ cd $BIGWORK
nhkwcaio@login03:/bigwork/nhkwcaio$ ls
gauss_scrdir
nhkwcaio@login03:/bigwork/nhkwcaio$ cd $LOGIN
nhkwcaio@login03:~$ ls
web-login

nhkwcaio@login03:/home$ cd /
nhkwcaio@login03:/$ pwd
/
nhkwcaio@login03:/$ ls
afs  bigwork  bin  boot  dev  etc  home  jupyterhub  lib  lib64  lost+found  media  mnt  opt  proc  project  root  run  sbin  software  srv  sw  sys  tmp  usr  var


nhkwcaio@login03:~$ slurmtop -u $USER 
Usage Totals: 13055/21136 Procs, 288/407 Nodes, 393/797 Jobs Running
Node States:   188 busy                   4 down                   7 down,offline         192 free                   9 offline                4 reserve                3 unknown

 Visible CPUs: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39
              1                                        2                                        3                                        4                                        5                                        6                                        7
              ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     vis-n001 ....................                     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         ********************************         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  taurus-n007 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  taurus-n014 ********************************         ********************************         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@..............         @@@@@@@@@@@@@@@@@@@@@@........@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

...


 [.] idle  [@] busy  [*] down  [%] offline  [!] other  [?] unknown


# Create simple SLURM job for learnign purposes!

made a small script hello_slurm.sh

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



#SBATCH --job-name=hello_test 
-   
#SBATCH --partition=amo
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --output=hello_test_%j.out
#SBATCH --error=hello_test_%j.err


(base) ocai@cowmatch005:~/agent-kibub$ scp hello_slurm.sh nhkwcaio@login.cluster.uni-hannover.de:/bigwork/nhkwcaio/
(nhkwcaio@login.cluster.uni-hannover.de) Password: 
hello_slurm.sh           

output files go into whatever directory you're in when you run sbatch 
SLURM_SUBMIT_DIR is automatically set by SLURM to the directory you submitted from.

cd /bigwork/nhkwcaio
sbatch hello_slurm.sh
The files hello_test_<JOBID>.out and hello_test_<JOBID>.err will appear in /bigwork/nhkwcaio/.

nhkwcaio@login03:~$ cd $BIGWORK
nhkwcaio@login03:/bigwork/nhkwcaio$ echo $SLURM_SUBMIT_DIR

nhkwcaio@login03:/bigwork/nhkwcaio$ ls
gauss_scrdir  hello_slurm.sh
nhkwcaio@login03:/bigwork/nhkwcaio$ sbatch hello_slurm.sh 
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: amo
Submitted batch job 7463449
nhkwcaio@login03:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:30:29 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
nhkwcaio@login03:/bigwork/nhkwcaio$ sbatch hello_slurm.sh 
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: amo
Submitted batch job 7463452
nhkwcaio@login03:/bigwork/nhkwcaio$ sbatch hello_slurm.sh 
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: amo
Submitted batch job 7463453
nhkwcaio@login03:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:30:55 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
           7463452       amo hello_te nhkwcaio  RUNNING       0:01      5:00      1 amo-n080
           7463453       amo hello_te nhkwcaio  RUNNING       0:01      5:00      1 amo-n080
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_
hello_slurm.sh          hello_test_7463449.err  hello_test_7463449.out  hello_test_7463452.err  hello_test_7463452.out  hello_test_7463453.err  hello_test_7463453.out  
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_
hello_slurm.sh          hello_test_7463449.err  hello_test_7463449.out  hello_test_7463452.err  hello_test_7463452.out  hello_test_7463453.err  hello_test_7463453.out  
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_test_74634
hello_test_7463449.err  hello_test_7463449.out  hello_test_7463452.err  hello_test_7463452.out  hello_test_7463453.err  hello_test_7463453.out  
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_test_74634
hello_test_7463449.err  hello_test_7463449.out  hello_test_7463452.err  hello_test_7463452.out  hello_test_7463453.err  hello_test_7463453.out  
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_test_7463449.
hello_test_7463449.err  hello_test_7463449.out  
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_test_7463449.err 
nhkwcaio@login03:/bigwork/nhkwcaio$ cat hello_test_7463449.out
=== Job Info ===
Job ID:    7463449
Job Name:  hello_test
Node:      amo-n080
Date:      Thu Jun 25 10:30:19 AM CEST 2026

=== Doing some work ===
Step 1 of 3...
Step 2 of 3...
Step 3 of 3...

Done! Job finished at Thu Jun 25 10:30:22 AM CEST 2026

nhkwcaio@login03:/bigwork/nhkwcaio$ ls
gauss_scrdir  hello_slurm.sh  hello_test_7463449.err  hello_test_7463449.out  hello_test_7463452.err  hello_test_7463452.out  hello_test_7463453.err  hello_test_7463453.out
nhkwcaio@login03:/bigwork/nhkwcaio$ rm hello_*
nhkwcaio@login03:/bigwork/nhkwcaio$ ls
gauss_scrdir




# job array and openmp

nhkwcaio@login01:/bigwork/nhkwcaio$ ls
gauss_scrdir  job_array.sh  job_openmp.sh

nhkwcaio@login01:/bigwork/nhkwcaio$ sbatch job_openmp.sh 
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: amo
Submitted batch job 7463480
nhkwcaio@login01:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:40:02 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
           7463480       amo openmp_t nhkwcaio  PENDING       0:00      5:00      1 (Resources)

## open mp
nhkwcaio@login01:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:42:49 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
           7463480       amo openmp_t nhkwcaio  PENDING       0:00      5:00      1 (Resources)
nhkwcaio@login01:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:46:23 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
nhkwcaio@login01:/bigwork/nhkwcaio$ ls
gauss_scrdir  job_array.sh  job_openmp.sh  openmp_test_7463480.err  openmp_test_7463480.out
nhkwcaio@login01:/bigwork/nhkwcaio$ cat openmp_test_7463480.out 
Job 7463480 on amo-n031 — using 4 CPUs
  Worker 1 starting...
  Worker 2 starting...
  Worker 4 starting...
  Worker 3 starting...
All workers done.
nhkwcaio@login01:/bigwork/nhkwcaio$ cat openmp_test_7463480.err 
nhkwcaio@login01:/bigwork/nhkwcaio$ reportseff 7463480
    JobID    State       Elapsed  TimeEff   CPUEff   MemEff 
  7463480  COMPLETED    00:00:04   1.3%      ---      0.0%  

## job array
nhkwcaio@login01:/bigwork/nhkwcaio$ sbatch job_array.sh 
sbatch: slurm_job_submit:INFO: Set partition of submitted job to: amo
Submitted batch job 7463498
nhkwcaio@login01:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:47:28 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
         7463498_3       amo array_te nhkwcaio  RUNNING       0:04      5:00      1 amo-n079
         7463498_4       amo array_te nhkwcaio  RUNNING       0:04      5:00      1 amo-n077
         7463498_5       amo array_te nhkwcaio  RUNNING       0:04      5:00      1 amo-n077
nhkwcaio@login01:/bigwork/nhkwcaio$ squeue -l --me          # see if it's queued/running
Thu Jun 25 10:47:33 2026
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
nhkwcaio@login01:/bigwork/nhkwcaio$ reportseff 7463498
      JobID    State       Elapsed  TimeEff   CPUEff   MemEff 
  7463498_1  COMPLETED    00:00:02   0.7%      ---      0.0%  
  7463498_2  COMPLETED    00:00:03   1.0%      ---      0.0%  
  7463498_3  COMPLETED    00:00:04   1.3%      ---      0.1%  
  7463498_4  COMPLETED    00:00:05   1.7%      ---      0.0%  
  7463498_5  COMPLETED    00:00:06   2.0%      ---      0.0%  

nhkwcaio@login01:/bigwork/nhkwcaio$ ls
array_test_7463498_1.err  array_test_7463498_2.err  array_test_7463498_3.err  array_test_7463498_4.err  array_test_7463498_5.err  gauss_scrdir  job_openmp.sh            openmp_test_7463480.out
array_test_7463498_1.out  array_test_7463498_2.out  array_test_7463498_3.out  array_test_7463498_4.out  array_test_7463498_5.out  job_array.sh  openmp_test_7463480.err
nhkwcaio@login01:/bigwork/nhkwcaio$ rm array_test_7463498_*
nhkwcaio@login01:/bigwork/nhkwcaio$ rm openmp_test_7463480.*
nhkwcaio@login01:/bigwork/nhkwcaio$ rm job_*
nhkwcaio@login01:/bigwork/nhkwcaio$ 



nhkwcaio@transfer:~$ echo $SOFTWARE $HOME $BIGWORK $PROJECT 
/home/nhkwcaio /bigwork/nhkwcaio /project/NHKW25031

nhkwcaio@login02:~$ echo $SOFTWARE $HOME $BIGWORK $PROJECT 
/software/NHKW25031 /home/nhkwcaio /bigwork/nhkwcaio /project/NHKW25031

nhkwcaio@transfer:~$ clusterinfo
-bash: clusterinfo: command not found

nhkwcaio@login02:~$ clusterinfo
==========================================================================
ATTENTION: Cluster maintenance is planned on Jun. 30 2026, 10:00:00 (CEST)
Note:      See https://docs.cluster.uni-hannover.de for details.
==========================================================================

Partition    Node List                                              Provider    Default Time    Max Time    AccessPolicy of nhkwcaio
-----------  -----------------------------------------------------  ----------  --------------  ----------  -------------------------------
amo          amo-n[001-080]                                         LUIS        1-00:00:00      8-08:00:00  Unrestricted
gpu.test     gpu-18-n012                                            LUIS        01:00:00        03:00:00    Unrestricted
gpu          gpu-20-n[005-008],gpu-22-n[009-011],gpu-25-n[001-004]  LUIS        01:00:00        2-00:00:00  Unrestricted
haku         haku-n[001-020]                                        LUIS        1-00:00:00      8-08:00:00  Unrestricted
jhub         jhub-n[005,010]                                        LUIS        01:00:00        2-00:00:00  Unrestricted
lena         lena-n[001-080]                                        LUIS        1-00:00:00      8-08:00:00  Unrestricted
mpp.single   mpp-25-n[001-010]                                      LUIS        01:00:00        2-00:00:00  Unrestricted
mpp.share    mpp-25-n[011-037]                                      LUIS        01:00:00        2-00:00:00  Unrestricted
smp          smp-23-n[010-011],smp-25-n[001-009]                    LUIS        12:00:00        8-08:00:00  Unrestricted
taurus       taurus-n[001-024]                                      LUIS        1-00:00:00      8-08:00:00  Unrestricted
vis          vis-n001                                               LUIS        01:00:00        03:00:00    Unrestricted
ai           ai-n[001-002,005-008]                                  FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
ainlp        ai-n[003-004]                                          FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
                                                                                                            Unrestricted
ai.h100      ai-n009                                                FCH         01:00:00        8-08:00:00  Denied (08:00:00 - 20:00:00)
ai.b300      ai-n[010-011]                                          FCH         01:00:00        8-08:00:00  Denied (09:02:50 - 20:00:00)
enos         enos-n[001-032]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
                                                                                                            Denied (10:30:00 - 11:30:00)
fi           fi-n001                                                FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
gih          gih-n002                                               FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imes.gpu     imes-n001                                              FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imes         imes-n002                                              FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
imuk         imuk-n[001-009]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
isd          isd-n[002-011]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
isu          isu-n[004-009]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
itp          itp-n[005-011]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
iwes         iwes-n[001-002]                                        FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
p4d          p4d-n[001-003]                                         FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
pcikoe       pcikoe-n[001-017]                                      FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
phd          phd-n[001-032]                                         FCH         1-00:00:00      8-08:00:00  Exclusive (08:00:00 - 20:00:00)
phdgpu       phdgpu-n001                                            FCH         1-00:00:00      8-08:00:00  Exclusive (08:00:00 - 20:00:00)
stahl        stahl-n[001-003]                                       FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)
tnt          tnt-n[003,005-006]                                     FCH         1-00:00:00      8-08:00:00  Denied (08:00:00 - 20:00:00)

Use -i or --column-info to display column descriptions
Use -v for verbose output, -vv for more details



nhkwcaio@login02:~$ srun --pty bash -l
srun: slurm_cli_filter: WARNING:
 Memory options not specified. The DefMemPerCPU value of the partition to be allocated will be used
 Time limit options not specified. The default time limit of the partition to be allocated will be used
srun: slurm_job_submit:INFO: Set partition of submitted job to stahl,ai.b300,phdgpu,isu,ai,lena,taurus,itp,smp,imes,imuk,mpp.share,fi,phd,amo,tnt,isd,iwes,enos,p4d,ai.h100,pcikoe,ainlp,gih,haku
srun: job 7463974 queued and waiting for resources
srun: job 7463974 has been allocated resources
nhkwcaio@lena-n080:~$ hostname
df -hT
mount | egrep 'home|bigwork|project|software'
lena-n080
df: /home/nhgjbawa: Stale file handle
Filesystem                                             Type      Size  Used Avail Use% Mounted on
/dev/sda2                                              ext4       15G  4.3G  9.7G  31% /
devtmpfs                                               devtmpfs  4.0M     0  4.0M   0% /dev
tmpfs                                                  tmpfs      32G     0   32G   0% /dev/shm
tmpfs                                                  tmpfs      13G  309M   13G   3% /run
/dev/sda1                                              ext4      974M  343M  565M  38% /boot
/dev/sda6                                              ext4      181G  924M  180G   1% /scratch
/dev/sda3                                              ext4       15G  579M   14G   5% /var
192.168.255.3@o2ib:192.168.255.4@o2ib:/bwlfs1          lustre    462T  136T  326T  30% /bigwork
fs6home.css.lan:/home/nhulgroo                         nfs4       15T  6.7T  8.1T  46% /home/nhulgroo
fs6home.css.lan:/home/nhgjrakr                         nfs4       15T  6.7T  8.1T  46% /home/nhgjrakr
fs6home.css.lan:/home/nhgjeeah                         nfs4       15T  6.7T  8.1T  46% /home/nhgjeeah
fs6home.css.lan:/home/nhkcmast                         nfs4       15T  6.7T  8.1T  46% /home/nhkcmast
fs6home.css.lan:/home/nhgjahel                         nfs4       15T  6.7T  8.1T  46% /home/nhgjahel
fs6home.css.lan:/home/nhkchkim                         nfs4       15T  6.7T  8.1T  46% /home/nhkchkim
fs6home.css.lan:/home/nhkbscha                         nfs4       15T  6.7T  8.1T  46% /home/nhkbscha
fs6home.css.lan:/home/nhbbrbai                         nfs4       15T  6.7T  8.1T  46% /home/nhbbrbai
fs6home.css.lan:/home/nhkcnith                         nfs4       15T  6.7T  8.1T  46% /home/nhkcnith
fs6home.css.lan:/home/nhulgaus                         nfs4       15T  6.7T  8.1T  46% /home/nhulgaus
fs6home.css.lan:/home/nhgegrim                         nfs4       15T  6.7T  8.1T  46% /home/nhgegrim
fs6home.css.lan:/home/nhml0204                         nfs4       15T  6.7T  8.1T  46% /home/nhml0204
fs6home.css.lan:/home/nhml0012                         nfs4       15T  6.7T  8.1T  46% /home/nhml0012
fs6home.css.lan:/home/nhgevenk                         nfs4       15T  6.7T  8.1T  46% /home/nhgevenk
fs6home.css.lan:/home/nhmlalan                         nfs4       15T  6.7T  8.1T  46% /home/nhmlalan
fs6home.css.lan:/home/nhml0205                         nfs4       15T  6.7T  8.1T  46% /home/nhml0205
fs6home.css.lan:/home/nhgd0066                         nfs4       15T  6.7T  8.1T  46% /home/nhgd0066
fs6home.css.lan:/home/nhgestah                         nfs4       15T  6.7T  8.1T  46% /home/nhgestah
fs6home.css.lan:/home/nhgealpe                         nfs4       15T  6.7T  8.1T  46% /home/nhgealpe
fs6home.css.lan:/home/nhgehack                         nfs4       15T  6.7T  8.1T  46% /home/nhgehack
fs6home.css.lan:/home/nhwp0137                         nfs4       15T  6.7T  8.1T  46% /home/nhwp0137
fs6home.css.lan:/home/nhkbappe                         nfs4       15T  6.7T  8.1T  46% /home/nhkbappe
fs6home.css.lan:/home/nhgkjahr                         nfs4       15T  6.7T  8.1T  46% /home/nhgkjahr
fs6home.css.lan:/home/nhginima                         nfs4       15T  6.7T  8.1T  46% /home/nhginima
fs6home.css.lan:/home/nhgdtgae                         nfs4       15T  6.7T  8.1T  46% /home/nhgdtgae
fs6home.css.lan:/home/nhml0146                         nfs4       15T  6.7T  8.1T  46% /home/nhml0146
fs6home.css.lan:/home/nhml0142                         nfs4       15T  6.7T  8.1T  46% /home/nhml0142
fs6home.css.lan:/home/nhml0087                         nfs4       15T  6.7T  8.1T  46% /home/nhml0087
fs6home.css.lan:/home/nhcariin                         nfs4       15T  6.7T  8.1T  46% /home/nhcariin
fs6home.css.lan:/home/nhml0021                         nfs4       15T  6.7T  8.1T  46% /home/nhml0021
fs6home.css.lan:/home/nhkcmabe                         nfs4       15T  6.7T  8.1T  46% /home/nhkcmabe
fs6home.css.lan:/home/nhml0171                         nfs4       15T  6.7T  8.1T  46% /home/nhml0171
fs6home.css.lan:/home/nhgeschu                         nfs4       15T  6.7T  8.1T  46% /home/nhgeschu
fs6home.css.lan:/home/nhgebhum                         nfs4       15T  6.7T  8.1T  46% /home/nhgebhum
fs6home.css.lan:/home/nhkctaeb                         nfs4       15T  6.7T  8.1T  46% /home/nhkctaeb
fs6home.css.lan:/home/nhgk0053                         nfs4       15T  6.7T  8.1T  46% /home/nhgk0053
fs6home.css.lan:/home/nhulserr                         nfs4       15T  6.7T  8.1T  46% /home/nhulserr
fs6home.css.lan:/home/nhml0200                         nfs4       15T  6.7T  8.1T  46% /home/nhml0200
fs6home.css.lan:/home/nhml0050                         nfs4       15T  6.7T  8.1T  46% /home/nhml0050
fs6home.css.lan:/home/nhgd0113                         nfs4       15T  6.7T  8.1T  46% /home/nhgd0113
fs6home.css.lan:/home/nhml0182                         nfs4       15T  6.7T  8.1T  46% /home/nhml0182
fs6home.css.lan:/home/nhml0068                         nfs4       15T  6.7T  8.1T  46% /home/nhml0068
fs6home.css.lan:/home/nhml0081                         nfs4       15T  6.7T  8.1T  46% /home/nhml0081
sw.css.lan:/srv/nfs/export/software/projects/ZZZZ10001 nfs       8.0T  3.0T  5.1T  37% /software/ZZZZ10001
sw.css.lan:/srv/nfs/export/software/projects/NHGJ21622 nfs       8.0T  3.0T  5.1T  37% /software/NHGJ21622
sw.css.lan:/srv/nfs/export/software/projects/NHKC24218 nfs       8.0T  3.0T  5.1T  37% /software/NHKC24218
sw.css.lan:/srv/nfs/export/software/projects/NHGK24730 nfs       8.0T  3.0T  5.1T  37% /software/NHGK24730
sw.css.lan:/srv/nfs/export/software/projects/NHGE24162 nfs       8.0T  3.0T  5.1T  37% /software/NHGE24162
sw-srv.ib.css.lan:/jupyterhub/courses                  nfs4      1.0T  561G  464G  55% /jupyterhub/courses
sw-srv.ib.css.lan:/avx2/apps/modules/arch              nfs4      7.5T  4.3T  3.3T  57% /sw/apps/modules/arch
sw-srv.ib.css.lan:/noarch/modules                      nfs4      7.5T  4.3T  3.3T  57% /sw/apps/modules/noarch
sw-srv.ib.css.lan:/avx2/apps/software/arch             nfs4      7.5T  4.3T  3.3T  57% /sw/apps/software/arch
sw-srv.ib.css.lan:/noarch/software                     nfs4      7.5T  4.3T  3.3T  57% /sw/apps/software/noarch
sw-srv.ib.css.lan:/system                              nfs4      7.5T  4.3T  3.3T  57% /sw/system
fs6home.css.lan:/home/nhkwcaio                         nfs4       15T  6.7T  8.1T  46% /home/nhkwcaio
192.168.255.3@o2ib:192.168.255.4@o2ib:/bwlfs1 on /bigwork type lustre (rw,checksum,flock,nouser_xattr,lruresize,lazystatfs,nouser_fid2path,verbose,encrypt)
/etc/auto.home on /home type autofs (rw,relatime,fd=7,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=25866)
fs6home.css.lan:/home/nhulgroo on /home/nhulgroo type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjrakr on /home/nhgjrakr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjbawa on /home/nhgjbawa type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjeeah on /home/nhgjeeah type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcmast on /home/nhkcmast type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjahel on /home/nhgjahel type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkchkim on /home/nhkchkim type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkbscha on /home/nhkbscha type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhbbrbai on /home/nhbbrbai type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcnith on /home/nhkcnith type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhulgaus on /home/nhulgaus type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgegrim on /home/nhgegrim type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0204 on /home/nhml0204 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0012 on /home/nhml0012 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgevenk on /home/nhgevenk type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhmlalan on /home/nhmlalan type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0205 on /home/nhml0205 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgd0066 on /home/nhgd0066 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgestah on /home/nhgestah type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgealpe on /home/nhgealpe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgehack on /home/nhgehack type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhwp0137 on /home/nhwp0137 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkbappe on /home/nhkbappe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgkjahr on /home/nhgkjahr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhginima on /home/nhginima type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgdtgae on /home/nhgdtgae type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0146 on /home/nhml0146 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0142 on /home/nhml0142 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0087 on /home/nhml0087 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhcariin on /home/nhcariin type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0021 on /home/nhml0021 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcmabe on /home/nhkcmabe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0171 on /home/nhml0171 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgeschu on /home/nhgeschu type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgebhum on /home/nhgebhum type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkctaeb on /home/nhkctaeb type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgk0053 on /home/nhgk0053 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhulserr on /home/nhulserr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0200 on /home/nhml0200 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0050 on /home/nhml0050 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgd0113 on /home/nhgd0113 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0182 on /home/nhml0182 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0068 on /home/nhml0068 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0081 on /home/nhml0081 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
/etc/auto.software on /software type autofs (rw,relatime,fd=10,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=25870)
sw.css.lan:/srv/nfs/export/software/projects/ZZZZ10001 on /software/ZZZZ10001 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGJ21622 on /software/NHGJ21622 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHKC24218 on /software/NHKC24218 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGK24730 on /software/NHGK24730 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGE24162 on /software/NHGE24162 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
/etc/autofs-mapper-apps_software.sh on /sw/apps/software type autofs (rw,relatime,fd=22,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=26940)
sw-srv.ib.css.lan:/avx2/apps/software/arch on /sw/apps/software/arch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
sw-srv.ib.css.lan:/noarch/software on /sw/apps/software/noarch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
fs6home.css.lan:/home/nhkwcaio on /home/nhkwcaio type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
nhkwcaio@lena-n080:~$ echo $HOME
echo $BIGWORK
echo $PROJECT
echo $SOFTWARE

df -h
mount
/home/nhkwcaio
/bigwork/nhkwcaio

/software/NHKW25031
df: /home/nhgjbawa: Stale file handle
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/sda2                                                15G  4.3G  9.7G  31% /
devtmpfs                                                4.0M     0  4.0M   0% /dev
tmpfs                                                    32G     0   32G   0% /dev/shm
tmpfs                                                    13G  309M   13G   3% /run
/dev/sda1                                               974M  343M  565M  38% /boot
/dev/sda6                                               181G  924M  180G   1% /scratch
/dev/sda3                                                15G  579M   14G   5% /var
192.168.255.3@o2ib:192.168.255.4@o2ib:/bwlfs1           462T  136T  326T  30% /bigwork
fs6home.css.lan:/home/nhulgroo                           15T  6.7T  8.1T  46% /home/nhulgroo
fs6home.css.lan:/home/nhgjrakr                           15T  6.7T  8.1T  46% /home/nhgjrakr
fs6home.css.lan:/home/nhgjeeah                           15T  6.7T  8.1T  46% /home/nhgjeeah
fs6home.css.lan:/home/nhkcmast                           15T  6.7T  8.1T  46% /home/nhkcmast
fs6home.css.lan:/home/nhgjahel                           15T  6.7T  8.1T  46% /home/nhgjahel
fs6home.css.lan:/home/nhkchkim                           15T  6.7T  8.1T  46% /home/nhkchkim
fs6home.css.lan:/home/nhkbscha                           15T  6.7T  8.1T  46% /home/nhkbscha
fs6home.css.lan:/home/nhbbrbai                           15T  6.7T  8.1T  46% /home/nhbbrbai
fs6home.css.lan:/home/nhkcnith                           15T  6.7T  8.1T  46% /home/nhkcnith
fs6home.css.lan:/home/nhulgaus                           15T  6.7T  8.1T  46% /home/nhulgaus
fs6home.css.lan:/home/nhgegrim                           15T  6.7T  8.1T  46% /home/nhgegrim
fs6home.css.lan:/home/nhml0204                           15T  6.7T  8.1T  46% /home/nhml0204
fs6home.css.lan:/home/nhml0012                           15T  6.7T  8.1T  46% /home/nhml0012
fs6home.css.lan:/home/nhgevenk                           15T  6.7T  8.1T  46% /home/nhgevenk
fs6home.css.lan:/home/nhmlalan                           15T  6.7T  8.1T  46% /home/nhmlalan
fs6home.css.lan:/home/nhml0205                           15T  6.7T  8.1T  46% /home/nhml0205
fs6home.css.lan:/home/nhgd0066                           15T  6.7T  8.1T  46% /home/nhgd0066
fs6home.css.lan:/home/nhgestah                           15T  6.7T  8.1T  46% /home/nhgestah
fs6home.css.lan:/home/nhgealpe                           15T  6.7T  8.1T  46% /home/nhgealpe
fs6home.css.lan:/home/nhgehack                           15T  6.7T  8.1T  46% /home/nhgehack
fs6home.css.lan:/home/nhwp0137                           15T  6.7T  8.1T  46% /home/nhwp0137
fs6home.css.lan:/home/nhkbappe                           15T  6.7T  8.1T  46% /home/nhkbappe
fs6home.css.lan:/home/nhgkjahr                           15T  6.7T  8.1T  46% /home/nhgkjahr
fs6home.css.lan:/home/nhginima                           15T  6.7T  8.1T  46% /home/nhginima
fs6home.css.lan:/home/nhgdtgae                           15T  6.7T  8.1T  46% /home/nhgdtgae
fs6home.css.lan:/home/nhml0146                           15T  6.7T  8.1T  46% /home/nhml0146
fs6home.css.lan:/home/nhml0142                           15T  6.7T  8.1T  46% /home/nhml0142
fs6home.css.lan:/home/nhml0087                           15T  6.7T  8.1T  46% /home/nhml0087
fs6home.css.lan:/home/nhcariin                           15T  6.7T  8.1T  46% /home/nhcariin
fs6home.css.lan:/home/nhml0021                           15T  6.7T  8.1T  46% /home/nhml0021
fs6home.css.lan:/home/nhkcmabe                           15T  6.7T  8.1T  46% /home/nhkcmabe
fs6home.css.lan:/home/nhml0171                           15T  6.7T  8.1T  46% /home/nhml0171
fs6home.css.lan:/home/nhgeschu                           15T  6.7T  8.1T  46% /home/nhgeschu
fs6home.css.lan:/home/nhgebhum                           15T  6.7T  8.1T  46% /home/nhgebhum
fs6home.css.lan:/home/nhkctaeb                           15T  6.7T  8.1T  46% /home/nhkctaeb
fs6home.css.lan:/home/nhgk0053                           15T  6.7T  8.1T  46% /home/nhgk0053
fs6home.css.lan:/home/nhulserr                           15T  6.7T  8.1T  46% /home/nhulserr
fs6home.css.lan:/home/nhml0200                           15T  6.7T  8.1T  46% /home/nhml0200
fs6home.css.lan:/home/nhml0050                           15T  6.7T  8.1T  46% /home/nhml0050
fs6home.css.lan:/home/nhgd0113                           15T  6.7T  8.1T  46% /home/nhgd0113
fs6home.css.lan:/home/nhml0182                           15T  6.7T  8.1T  46% /home/nhml0182
fs6home.css.lan:/home/nhml0068                           15T  6.7T  8.1T  46% /home/nhml0068
fs6home.css.lan:/home/nhml0081                           15T  6.7T  8.1T  46% /home/nhml0081
sw.css.lan:/srv/nfs/export/software/projects/ZZZZ10001  8.0T  3.0T  5.1T  37% /software/ZZZZ10001
sw.css.lan:/srv/nfs/export/software/projects/NHGJ21622  8.0T  3.0T  5.1T  37% /software/NHGJ21622
sw.css.lan:/srv/nfs/export/software/projects/NHKC24218  8.0T  3.0T  5.1T  37% /software/NHKC24218
sw.css.lan:/srv/nfs/export/software/projects/NHGK24730  8.0T  3.0T  5.1T  37% /software/NHGK24730
sw.css.lan:/srv/nfs/export/software/projects/NHGE24162  8.0T  3.0T  5.1T  37% /software/NHGE24162
sw-srv.ib.css.lan:/jupyterhub/courses                   1.0T  561G  464G  55% /jupyterhub/courses
sw-srv.ib.css.lan:/avx2/apps/modules/arch               7.5T  4.3T  3.3T  57% /sw/apps/modules/arch
sw-srv.ib.css.lan:/noarch/modules                       7.5T  4.3T  3.3T  57% /sw/apps/modules/noarch
sw-srv.ib.css.lan:/avx2/apps/software/arch              7.5T  4.3T  3.3T  57% /sw/apps/software/arch
sw-srv.ib.css.lan:/noarch/software                      7.5T  4.3T  3.3T  57% /sw/apps/software/noarch
sw-srv.ib.css.lan:/system                               7.5T  4.3T  3.3T  57% /sw/system
fs6home.css.lan:/home/nhkwcaio                           15T  6.7T  8.1T  46% /home/nhkwcaio
/dev/sda2 on / type ext4 (rw,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=4096k,nr_inodes=8156983,mode=755,inode64)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
tmpfs on /run type tmpfs (rw,nosuid,nodev,size=13062064k,nr_inodes=819200,mode=755,inode64)
none on /run/credentials/systemd-sysctl.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
none on /run/credentials/systemd-tmpfiles-setup-dev.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
none on /run/credentials/systemd-tmpfiles-setup.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=29,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=21974)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,nosuid,nodev,noexec,relatime)
/dev/sda1 on /boot type ext4 (rw,relatime)
/dev/sda6 on /scratch type ext4 (rw,relatime)
/dev/sda3 on /var type ext4 (rw,relatime)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
192.168.255.3@o2ib:192.168.255.4@o2ib:/bwlfs1 on /bigwork type lustre (rw,checksum,flock,nouser_xattr,lruresize,lazystatfs,nouser_fid2path,verbose,encrypt)
/etc/auto.home on /home type autofs (rw,relatime,fd=7,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=25866)
fs6home.css.lan:/home/nhulgroo on /home/nhulgroo type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjrakr on /home/nhgjrakr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjbawa on /home/nhgjbawa type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjeeah on /home/nhgjeeah type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcmast on /home/nhkcmast type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgjahel on /home/nhgjahel type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkchkim on /home/nhkchkim type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkbscha on /home/nhkbscha type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhbbrbai on /home/nhbbrbai type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcnith on /home/nhkcnith type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhulgaus on /home/nhulgaus type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgegrim on /home/nhgegrim type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0204 on /home/nhml0204 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0012 on /home/nhml0012 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgevenk on /home/nhgevenk type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhmlalan on /home/nhmlalan type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0205 on /home/nhml0205 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgd0066 on /home/nhgd0066 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgestah on /home/nhgestah type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgealpe on /home/nhgealpe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgehack on /home/nhgehack type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhwp0137 on /home/nhwp0137 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkbappe on /home/nhkbappe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgkjahr on /home/nhgkjahr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhginima on /home/nhginima type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgdtgae on /home/nhgdtgae type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0146 on /home/nhml0146 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0142 on /home/nhml0142 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0087 on /home/nhml0087 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhcariin on /home/nhcariin type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0021 on /home/nhml0021 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkcmabe on /home/nhkcmabe type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0171 on /home/nhml0171 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgeschu on /home/nhgeschu type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgebhum on /home/nhgebhum type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhkctaeb on /home/nhkctaeb type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgk0053 on /home/nhgk0053 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhulserr on /home/nhulserr type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0200 on /home/nhml0200 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0050 on /home/nhml0050 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhgd0113 on /home/nhgd0113 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0182 on /home/nhml0182 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0068 on /home/nhml0068 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
fs6home.css.lan:/home/nhml0081 on /home/nhml0081 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)
/etc/auto.software on /software type autofs (rw,relatime,fd=10,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=25870)
sw.css.lan:/srv/nfs/export/software/projects/ZZZZ10001 on /software/ZZZZ10001 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGJ21622 on /software/NHGJ21622 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHKC24218 on /software/NHKC24218 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGK24730 on /software/NHGK24730 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
sw.css.lan:/srv/nfs/export/software/projects/NHGE24162 on /software/NHGE24162 type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=3,sec=sys,mountaddr=10.7.132.63,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.7.132.63)
/etc/auto.jupyterhub on /jupyterhub type autofs (rw,relatime,fd=13,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=30118)
sw-srv.ib.css.lan:/jupyterhub/courses on /jupyterhub/courses type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
/etc/auto.system on /sw type autofs (rw,relatime,fd=16,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=21009)
/etc/autofs-mapper-apps_modules.sh on /sw/apps/modules type autofs (rw,relatime,fd=19,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=22350)
sw-srv.ib.css.lan:/avx2/apps/modules/arch on /sw/apps/modules/arch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
sw-srv.ib.css.lan:/noarch/modules on /sw/apps/modules/noarch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
/etc/autofs-mapper-apps_software.sh on /sw/apps/software type autofs (rw,relatime,fd=22,pgrp=1180,timeout=3600,minproto=5,maxproto=5,indirect,pipe_ino=26940)
sw-srv.ib.css.lan:/avx2/apps/software/arch on /sw/apps/software/arch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
sw-srv.ib.css.lan:/noarch/software on /sw/apps/software/noarch type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
sw-srv.ib.css.lan:/system on /sw/system type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=300,retrans=5,sec=sys,clientaddr=192.168.148.80,local_lock=none,addr=192.168.132.68)
/dev/sda6 on /tmp type ext4 (rw,relatime)
tmpfs on /dev/shm type tmpfs (rw,relatime,inode64)
fs6home.css.lan:/home/nhkwcaio on /home/nhkwcaio type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.7.148.80,local_lock=none,addr=10.7.132.58)


nhkwcaio@lena-n080:~$ echo $TMPDIR
/tmp


 mkdir -m 0700 $PROJECT/nhkwcaio


nhkwcaio@login02:~$ mpirun -np 4 dsync $BIGWORK/openmp_results/ $PROJECT/nhkwcaio/openmp_results/
[2026-06-25T15:45:13] Walking source path
[2026-06-25T15:45:13] Walking /bigwork/nhkwcaio/openmp_results
[2026-06-25T15:45:13] Walked 7 items in 0.006 secs (1166.632 items/sec) ...
[2026-06-25T15:45:13] Walked 7 items in 0.006 seconds (1149.710 items/sec)
[2026-06-25T15:45:13] Walking destination path
[2026-06-25T15:45:13] Walking /project/NHKW25031/nhkwcaio/openmp_results
[2026-06-25T15:45:13] [0] [/scratch/easybuild/zzzzjenk/build/mpifileutils/0.11/gompi-2019b/mpifileutils-0.11/src/common/mfu_flist_walk.c:532] ERROR: Failed to stat: '/project/NHKW25031/nhkwcaio/openmp_results' (errno=2 No such file or directory)
[2026-06-25T15:45:13] Walked 0 items in 0.001 secs (0.000 items/sec) ...
[2026-06-25T15:45:13] Walked 0 items in 0.001 seconds (0.000 items/sec)
[2026-06-25T15:45:13] Started   : Jun-25-2026, 15:45:13
[2026-06-25T15:45:13] Completed : Jun-25-2026, 15:45:13
[2026-06-25T15:45:13] Seconds   : 0.000
[2026-06-25T15:45:13] Items     : 0
[2026-06-25T15:45:13] Item Rate : 0 items in 0.000131 seconds (0.000000 items/sec)
[2026-06-25T15:45:13] Copying items to destination
[2026-06-25T15:45:13] Copying to /project/NHKW25031/nhkwcaio/openmp_results
[2026-06-25T15:45:13] Items: 7
[2026-06-25T15:45:13]   Directories: 1
[2026-06-25T15:45:13]   Files: 6
[2026-06-25T15:45:13]   Links: 0
[2026-06-25T15:45:13] Data: 453.000 B (75.000 B per file)
[2026-06-25T15:45:13] Creating 1 directories
[2026-06-25T15:45:13] Creating 6 files.
[2026-06-25T15:45:13] Copying data.
[2026-06-25T15:45:13] Copy data: 453.000 B (453 bytes)
[2026-06-25T15:45:13] Copy rate: 10.050 KiB/s (453 bytes in 0.044 seconds)
[2026-06-25T15:45:13] Syncing data to disk.
[2026-06-25T15:45:15] Sync completed in 2.357 seconds.
[2026-06-25T15:45:15] Setting ownership, permissions, and timestamps.
[2026-06-25T15:45:15] Updated 7 items in 0.003 seconds (2106.040 items/sec)
[2026-06-25T15:45:15] Syncing directory updates to disk.
[2026-06-25T15:45:16] Sync completed in 0.309 seconds.
[2026-06-25T15:45:16] Started: Jun-25-2026,15:45:13
[2026-06-25T15:45:16] Completed: Jun-25-2026,15:45:16
[2026-06-25T15:45:16] Seconds: 2.716
[2026-06-25T15:45:16] Items: 7
[2026-06-25T15:45:16]   Directories: 1
[2026-06-25T15:45:16]   Files: 6
[2026-06-25T15:45:16]   Links: 0
[2026-06-25T15:45:16] Data: 453.000 B (453 bytes)
[2026-06-25T15:45:16] Rate: 166.769 B/s (453 bytes in 2.716 seconds)
[2026-06-25T15:45:16] Updating timestamps on newly copied files
