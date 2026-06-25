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
