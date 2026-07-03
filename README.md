# agent-kibub
'Agent Kibub' refers to the OpenClaw agentic system embodied on a dual arm, differential drive mobile robot system 'Kibub'.  This master repository contains the submodules needed to teleop, train, inference on Kibub, and the agent setup for OpenClaw.

## Getting Started

#### Hardware prerequisites:
1. Kibub robot (dual SO101 arms, each with wrist cameras, differential driver wheel base, overhead/neck cameras)
3. Leader teleop arms for collecting demonstrations only
4. Robot **Client** computer (Intel NUC)
5. Policy **Server** computer for rollout (CUDA device)
6. Anker power supply or wall power supply 

#### Software prerequisites:
1. A Linux based OS on both the client and server devices 
2. An API key to run the OpenClaw client
3. A Huggingface account to manage & download datasets & models online
4. Optional: A Weights and Biases account if you would like to log training performances
5. Optional: A computing cluster username and password if you would like to train models on the cluster instead of your CUDA device.

A few preliminary notes on the software setup:
- **Server** will refer to the Policy Server computer (CUDA device), while **Client** will refer to the Robot Client computer (Intel NUC)

#### Server Software Setup:
1. Run `cd /home/$(whoami)/` (or wherever you'd like to put this repo)
2. Clone the repository agent-kibub (https://github.com/olivecai/agent-kibub) on the **Server**.
2. Initialize and update the submodule repositories by running `cd agent-kibub; git submodule init; git submodule update`
3. Install miniconda so that you can use virtual environments to manage packages: https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install (`curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh` and after it has installed, `source ~/.bashrc`)
4. Run the cmd to setup the server environment: `./CreateVenv-SERVER.sh`

#### Client Software Setup:

*Presumably Kibub has already been set up but these steps will be documented for redundancy*

1. Launch a Kibub SSH session: `ssh kibub@kibub`. 
2. Clone the following three repositories in /home/kibub/: kibub-neck-servos (https://github.com/olivecai/kibub-neck-servos), kibub_diff_drive (https://github.com/olivecai/kibub_diff_drive), and kibub_operator (https://github.com/olivecai/kibub_operator). If they are already cloned, cd into each of them and `git pull origin main`
3. Run `conda create env -n lerobot -y; conda activate lerobot`
4. Run `cd kibub_operator; pip install -r client-requirements.txt`
5. Check which of the following devices are enumerated upon running `ls /dev`. Attempt to plug in the follower and leaders arms, and all the cameras which you would like to use during rollout. The table below describes the hardware and when it is needed. 

- teleop == teleoperating the follower arms via the leader arms 
- vla record == recording a dataset to train a VLA model
- vla train == training a VLA model
- vla rollout == deploying a VLA model on the follower arms
- agent rollout == deploying the OpenClaw AI agent onto the full kibub system (includes wheels, neck, arms, facial recognitiion)

symlink name | description | needed during teleop, vla record, vla train, vla rollout, agent rollout |
--- | --- | --- |
follower_right | right follower so101 arm | teleop, vla record, vla rollout, agent rollout |
follower_left | left follower so101 arm | teleop, vla record, vla rollout, agent rollout |
leader_right | right leader so101 arm | teleop, vla record |
leader_left | left leader so101 arm | teleop, vla record |
wrist_left | left wrist cam | optional: vla record, vla rollout, agent rollout |
wrist_right | right wrist cam | optional: vla record, vla rollout, agent rollout |
top_realsense_color | neck realsense camera color channel | optional: vla record, vla rollout, agent rollout |
top_realsense_depth | neck realsense camera depth channel | optional: vla record, vla rollout, agent rollout |
overhead_realsense | overhead birdeye realsense camera color channel | optional: vla record, vla rollout, agent rollout |
diff_drive | differential wheels | agent rollout |

If you are missing a symlink, or add another peripheral, **ADD IT AS A SYMLINK** to avoid the unfortunate TODOTODO

```
sudo nano /etc/udev/rules.d/99-top-cameras.rules

sudo udevadm control --reload-rules
sudo udevadm trigger

```





    MANDATORY: wrist_left, wrist_right, follower_left, follower_right, 
```
Run `ls /dev/`
```
Set up the udev rules for the cams and the wrists if not alr done etc
3. 

## Teleop, recording datasets, rollout trained policies:

Reference agent-kibub/kibub_operator/README.md.

This repositories includes instructions on runn

## Openclaw agent




