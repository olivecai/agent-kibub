# agent-kibub
'Agent Kibub' refers to the OpenClaw agentic system embodied on a dual arm, differential drive mobile robot system 'Kibub'.  This master repository contains the submodules needed to teleop, train, inference on Kibub, and the agent setup for OpenClaw.

## Getting Started

#### Hardware prerequisites:
1. Kibub robot (dual SO101 arms, each with wrist cameras, differential driver wheel base, overhead/neck cameras)
3. Leader teleop arms for collecting demonstrations only
4. Robot **Client** computer (Intel NUC)
5. Policy **Server** computer (CUDA device)
6. Anker power supply or wall power supply 

#### Software prerequisites:
1. A Linux based OS on both the client and server devices 
2. An API key to run the OpenClaw client
3. A Huggingface account to manage datasets and models online
4. A Weights and Biases account if you would like to log training performance

A few preliminary notes on the software setup:
- **Server** will refer to the Policy Server computer (CUDA device), while **Client** will refer to the Robot Client computer (Intel NUC)

#### Server Software Setup:
1. Run `cd /home/$(whoami)/`
2. Clone the repository agent-kibub (https://github.com/olivecai/agent-kibub) on the **Server**.
2. Initialize and update the submodule repositories by running `cd agent-kibub; git submodule init; git submodule update`
3. Install miniconda so that you can use virtual environments to manage packages: https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install
4. Create necessary virtual enviornments: `./home/$(whoami)/agent-kibub/create_venv_server`

#### Client Software Setup:
1. Clone lerobot and kibub_operator repositories
2. set up the udev rules for the cams and the wrists if not alr done etc
3. 

#### TODO:
- Add submods
- Add instructions for computing cluster


