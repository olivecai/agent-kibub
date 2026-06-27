
When do i need interactive jobs? 

I dont think i need them

Login node you can acess both project and workspace

but never compuite from the login node



BIGWORK  --> (job runs)  -->  PROJECT  -->  (download to your laptop)
/bigwork/nhkwcaio           /project/NHKW25031/nhkwcaio
  fast, job-accessible        safe long-term storage, login-node only
BIGWORK ($BIGWORK) — your kitchen. Run all jobs here. It is NOT automatically deleted, but it has a quota with a 30-day grace period. If you blow past your soft quota, you can't write new data after 30 days.. therefore clean it out regularly.

PROJECT ($PROJECT) — your pantry/safe storage. Not mounted on compute nodes so jobs can't write there directly. You copy finished results here from the login node after a job completes. This is where you keep things you don't want to lose.

HOME — only for small config files (.bashrc, SSH keys, etc.). Slow and tiny quota.

TMPDIR — fastest local disk on the compute node, but wiped automatically when your job ends. Use it mid-job for intermediate scratch files.


WORKFLOW:
1. put scripts and input data in BIGWORK
2. sbatch job (reads writes in BIGWORK) 
3. when done, from login node copy results to project: dsync $BIGWORK/myresults $PROJECT/nhkwcaio/myresults (or cp for one file or dcp)
4. download to laptop from transfer node: scp nhkwcaio@transfer.cluster.uni-hannover.de:/project/NHKW25031/nhkwcaio/myresults ./ #use transfer.cluster.uni-hannover.de, not login, so a 30-min CPU limit doesn't kill your transfer

**how much time and gb do i know to request?**

Quick reference starting points:

Workload	Time guess	Memory guess
Small Python script	00:30:00	2G
Medium ML training	04:00:00	8G
Large data processing	08:00:00	16G
GPU job	02:00:00	4G + --gres=gpu:...



