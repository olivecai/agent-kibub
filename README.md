# agent-kibub
'Agent Kibub' refers to the OpenClaw agentic system embodied on a dual arm, differential drive mobile robot system 'Kibub'.  This master repository contains the submodules needed to teleop, train, inference on Kibub, and the agent setup for OpenClaw.

Submodules within this repository:
- openclaw-embodied
- kibub_diff_drive
- kibub_operator
- kibub-neck-servos
- lerobot
- cluster

Editing the submodules:
1. cd into the submodule and `git checkout main`. Do not edit in the detached HEAD state.
2. After making your edits, push your changes to the submodule repository. Note that this step does not update agent-kibub's record of which submodule commit to track: 
```
`git add .
git commit -m "fix: something"
git push origin main
```
3. Now update the parent repo (agent-kibub) to bookmark the latest commit of the submodule:
```
cd ../..    # back to parent repo root
git status  # you'll see the submodule listed as "modified" (new commits)
git add path/to/submodule
git commit -m "Update submodule to latest fix"
git push origin main
```

## Setup

### Hardware prerequisites:
1. Kibub robot (dual SO101 arms, each with wrist cameras, differential driver wheel base, overhead/neck cameras)
3. Leader teleop arms for collecting demonstrations only
4. Robot **Client** computer (Intel NUC)
5. Policy **Server** computer for rollout (CUDA device)
6. Anker power supply or wall power supply 

### Software prerequisites:
1. A Linux based OS on both the client and server devices 
2. An API key to run the OpenClaw client
3. A Huggingface account to manage & download datasets & models online
4. Optional: A Weights and Biases account if you would like to log training performances
5. Optional: A computing cluster username and password if you would like to train models on the cluster instead of your CUDA device.

A few preliminary notes on the software setup:
- **Server** will refer to the Policy Server computer (CUDA device), while **Client** will refer to the Robot Client computer (Intel NUC)

### Server Software Setup:
1. Run `cd /home/$(whoami)/` (or wherever you'd like to put this repo)
2. Clone the repository agent-kibub (https://github.com/olivecai/agent-kibub) on the **Server**.
2. Initialize and update the submodule repositories by running `cd agent-kibub; git submodule init; git submodule update; git pull origin main`

Example:
```
(base) ocai@cowmatch005:~/agent-kibub$ git submodule init
(base) ocai@cowmatch005:~/agent-kibub$ git submodule update
Cloning into '/home/ocai/agent-kibub/kibub-neck-servos'...
Cloning into '/home/ocai/agent-kibub/kibub_diff_drive'...
Cloning into '/home/ocai/agent-kibub/kibub_operator'...
Cloning into '/home/ocai/agent-kibub/lerobot'...
Cloning into '/home/ocai/agent-kibub/openclaw-embodied'...
Submodule path 'kibub-neck-servos': checked out '1cf39ca7da8581378ce61b0300dc43eb97fa65c8'
Submodule path 'kibub_diff_drive': checked out '0cde00a1e4711ca995e222eaf0e162a1dc784def'
Submodule path 'kibub_operator': checked out '4f6f7751a4e58a433b302625c8ab0a3efdd3f6e3'
Submodule path 'lerobot': checked out '6e6a3b963c5f0425a380daf21a40c17f82f50d06'
Submodule path 'openclaw-embodied': checked out '410d05fec9794f33d22340ce7ad5bd937dc218ca'
(base) ocai@cowmatch005:~/agent-kibub$ git pull
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 4.03 KiB | 4.03 MiB/s, done.
From github.com:olivecai/agent-kibub
   a80d9c9..435ed53  main       -> origin/main
Updating a80d9c9..435ed53
Fast-forward
 README.md      | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 kibub_operator |   2 +-
```

3. Install miniconda so that you can use virtual environments to manage packages: https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install (`curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh` and after it has installed, `source ~/.bashrc`)
4. You have two options in setting up the server env: either run the cmd to setup the server environment with a script: `chmod a+x CreateEnv-SERVER.sh; ./CreateEnv-SERVER.sh`, OR execute the following line by line with current working directory within agent-kibub:
```
# either run the following one by one, or run `chmod a+x CreateEnv-SERVER.sh; ./CreateEnv-SERVER.sh`
git submodule init
git submodule update

git pull origin main # or pull whichever branch/checkpoint you need

conda create -n lerobot python=3.12 -y
conda activate lerobot 

pip install -r server_requirements.txt # flash-attn is installed seperately in next step

pip install flash_attn==2.8.3 --no-cache-dir --no-build-isolation

# install openclaw, add your Openrouter API key.
curl -fsSL https://openclaw.ai/install.sh | bash

```

#### OpenClaw Agent

5. In the previous step, you installed OpenClaw. Your agent relies on Markdown files describing its personality and responsibilities; you can modify these Markdown files, or you can reuse the current Markdown files existing in agent-kibub/openclaw-embodied. *NOTE* that the current workspace for the AI agent is .openclaw/workspace, and in the next step you will change the workspace location to where the Markdown files are also stored:

```
AGENTS.md
HEARTBEAT.md  
IDENTITY.md  
MEMORY.md 
SOUL.md  
TOOLS.md  
USER.md
```
You can reuse these files or create your own agent identity.

6. Configure your agent's json file: 

Suppose you want to use the following models (you can find more models on Openrouter: https://openrouter.ai/models):

  ```
  openrouter/auto                                                                                                      
  openrouter/free                                                                                                      
  openrouter/owl-alpha                                                                                                 
  openrouter/google/gemini-2.5-flash-lite                                                                              
  openrouter/deepseek/deepseek-v4-flash 
  ```

You can add the entry to the file .openclaw/openclaw.json by running `nano /home/$(whoami)/.openclaw/openclaw.json` and editing agents::defaults::models. 

You also must edit the agent's workspace. The default workspace set by the Openclaw installation is `.openclaw/workspace` but you must change this to the openclaw-embodied directory (if you cloned agent-kibub into /home/USER/, change the workspace path to `/home/USER/agent-kibub/openclaw-embodied`)

See the example of the "agents" entry in my json below:
```
    "agents": {
        "defaults": {
          "workspace": "/home/ocai/openclaw-embodied",
          "models": {
            "openrouter/auto": {
              "alias": "OpenRouter"
            },
            "openrouter/free": {},
            "openrouter/owl-alpha": {},
            "openrouter/google/gemini-2.5-flash-lite": {},
            "openrouter/deepseek/deepseek-v4-flash": {}
          },
          "model": {
            "primary": "openrouter/google/gemini-2.5-flash-lite",
            "fallbacks": [
              "openrouter/auto",
              "openrouter/free",
              "openrouter/owl-alpha"
            ]
          }
        }
      },
```

To exit nano and save the changes: `Ctrl+X`, then `y`

7. In the OpenClaw terminal: `talk to agent`
8. You can now prompt the agent to evaluate its workspace and decide what to do:

Example

**USER PROMPT:** "Imagine you executed evaluate_status and saw that there was a cup to the left of your workspace. What skill would you deploy, and what would your reasoning   
        be? What would you do after executing that skill?"

**AGENT RESPONSE:**
                                                                                                                                                                    
        Skill: pick-up-cup-left-arm                                                                                                                                   
                                                                                                                                                                    
        Reasoning: The cup is on the left → the left arm is closest and has the best reach path. Using the right arm would mean crossing the robot's centerline,      
        risking cable snags and a worse wrist angle. The GROOT model for pick-up-cup-left-arm was trained for this exact task ("Pick up the cup using the cup         
        handle"). So export SKILL=pick-up-cup-left-arm, bash the deploy script, and let it cook.                                                                      
                                                                                                                                                                    
        After executing: Run evaluate-status again. Pull the overhead_realsense image and check:                                                                      
                                                                                                                                                                    
        - SUCCESS → cup's off the table? Report done. Ask if they want it placed somewhere or if there's a stack task next.                                           
        - FAILED → cup still on the table? Look at the image for why — gripper missed? Cup tipped? Handle orientation wrong? Adjust and retry, or admit the model's   
        having a bad day.                                                                                                                                           
        - IN_PROGRESS → wait, re-evaluate in a few seconds.                                                                                                           
        - UNCLEAR → check the wrist cameras. Maybe the overhead view is blocked by the arm.                                                                           
                                                                                                                                                                    
        That's the loop: deploy → observe → decide. Don't blindly retry, don't assume success.                                                                        
                                                                                                                                                                    
        Want me to actually do this if the robot comes back, or was this purely hypothetical cheese? 🧀      

-------------------- **You are now finished the Server Software Setup** -------------------- 

### Client Software Setup:

*Presumably Kibub has already been set up but these steps will be documented for redundancy*

#### Passwordless SSH and connection between Client and Server

1. Set up a passwordless SSH connection between the Client and Server, so that the AI agent can execute commands on Kibub directly. Generate a key on the Server if you don't have one: `ssh-keygen -t ed25519`. 

2. Copy the key from the Server to the Client. This will prompt for the password to kibub@kibub, and then never again: `ssh-copy-id kibub@kibub`

3. Paste the Client's IP address in the document agent-kibub/openclaw-embodied/KIBUB_IP. To find the Client IP address, SSH into Kibub and run `ip a`. Then, find the address under `wlp46s0`. See the example below, where the fourth entry `wlp46s0` indicates that Kibub' IP address is `10.145.8.176`. *(Note that the IP address likely only needs to be set up once but can change)*:

    ```
    (base) kibub@kibub:~$ ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host noprefixroute 
        valid_lft forever preferred_lft forever
    2: enp45s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
        link/ether a8:a1:59:d1:3f:26 brd ff:ff:ff:ff:ff:ff
    3: enp47s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
        link/ether a8:a1:59:d1:3f:27 brd ff:ff:ff:ff:ff:ff
    4: wlp46s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether bc:09:1b:f3:00:f7 brd ff:ff:ff:ff:ff:ff
        inet ***10.145.8.176***/24 brd 10.145.8.255 scope global dynamic noprefixroute wlp46s0
        valid_lft 84732sec preferred_lft 84732sec
        inet6 fe80::468d:503b:8449:53aa/64 scope link noprefixroute 
        valid_lft forever preferred_lft forever
    5: tailscale0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq_codel state UNKNOWN group default qlen 500
        link/none 
        inet 100.100.215.15/32 scope global tailscale0
        valid_lft forever preferred_lft forever
        inet6 fd7a:115c:a1e0::fd38:d70f/128 scope global 
        valid_lft forever preferred_lft forever
        inet6 fe80::85b0:94ee:21f:30c2/64 scope link stable-privacy 
        valid_lft forever preferred_lft forever
    6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
        link/ether b2:52:14:89:a1:15 brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
        valid_lft forever preferred_lft forever


Follow instructions below **OR** power on the Client and run the following from the Server shell with current working directory as agent-kibub: `chmod a+x CreateEnv-CLIENT.sh; ./CreateEnv-CLIENT.sh`.
1. Launch a Kibub SSH session: `ssh kibub@kibub`. 
2. Clone the following three repositories in /home/kibub/: kibub-neck-servos (https://github.com/olivecai/kibub-neck-servos), kibub_diff_drive (https://github.com/olivecai/kibub_diff_drive), and kibub_operator (https://github.com/olivecai/kibub_operator). If they are already cloned, cd into each of them and `git pull origin main`
3. Run `conda create -n lerobot -y; conda activate lerobot`
4. Run `cd kibub_operator; pip install -r /home/kibub/client_requirements.txt`

#### Symlinks and Devices

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


If you are missing a symlink, add it using udev rules *and* add it to the DEVICES.py file:

1. Find your device in the device tree, listed as something like /dev/ttyACM0 or /dev/ttyUSB1, etc. You can see which cameras lerobot identifies by running: `conda activate lerobot; cd /home/kibub; lerobot-find-cameras`
Example output from `lerobot-find-cameras`:
```
--- Detected Cameras ---
Camera #0:
  Name: OpenCV Camera @ /dev/video0
  Type: OpenCV
  Id: /dev/video0
  Backend api: V4L2
  Default stream profile:
    Format: 0.0
    Fourcc: MJPG
    Width: 640
    Height: 480
    Fps: 30.0
--------------------
Camera #1:
  Name: OpenCV Camera @ /dev/video2
  Type: OpenCV
  Id: /dev/video2
  Backend api: V4L2
  Default stream profile:
    Format: 0.0
    Fourcc: MJPG
    Width: 640
    Height: 480
    Fps: 30.0
--------------------
Camera #2:
  Name: OpenCV Camera @ /dev/video6
  Type: OpenCV
  Id: /dev/video6
  Backend api: V4L2
  Default stream profile:
    Format: 0.0
    Fourcc: MJPG
    Width: 640
    Height: 480
    Fps: 30.0
--------------------
Camera #3:
  Name: OpenCV Camera @ /dev/video8
  Type: OpenCV
  Id: /dev/video8
  Backend api: V4L2
  Default stream profile:
    Format: 0.0
    Fourcc: MJPG
    Width: 640
    Height: 480
    Fps: 30.0
--------------------
Camera #4:
  Name: Intel RealSense D435
  Type: RealSense
  Id: 727212070348
  Firmware version: 5.17.0.10
  Usb type descriptor: 3.2
  Physical port: /sys/devices/pci0000:00/0000:00:14.0/usb4/4-3/4-3:1.0/video4linux/video4
  Product id: 0B07
  Product line: D400
  Default stream profile:
    Stream_type: Color
    Format: rgb8
    Width: 640
    Height: 480
    Fps: 30
```

2. use scp to transfer output images from the Client to the Server to view them: from the Server, run `scp kibub@kibub:/home/kibub/outputs/captured_images .`

3. Identify the camera stream you are trying to create the symlink for based on the captured images. Suppose your device is /dev/video4.

4. Run `udevadm info --query=all --name=/dev/video4 | grep -E 'ID_SERIAL|ID_USB_INTERFACE_NUM|ID_V4L_CAPABILITIES'

Example
```
(lerobot) kibub@kibub:~$ udevadm info --query=all --name=/dev/video4 | grep -E 'ID_SERIAL|ID_USB_INTERFACE_NUM|ID_V4L_CAPABILITIES'
E: ID_V4L_CAPABILITIES=:capture:
E: ID_SERIAL=Intel_R__RealSense_TM__Depth_Camera_435_Intel_R__RealSense_TM__Depth_Camera_435_804113020213
E: ID_SERIAL_SHORT=804113020213
E: ID_USB_INTERFACE_NUM=00
```

5. Then run `cat /sys/class/video4linux/video4/index` to obtain the field ATTR{index}. 

Example
```
(lerobot) kibub@kibub:~$ cat /sys/class/video4linux/video4/index
0
```

6. Finally, run `sudo nano /etc/udev/rules.d/99-top-cameras.rules` and add your own device entry at the bottom of the file. (DO NOT REMOVE CURRENT ENTRIES TO THIS FILE). Arrange the following string to match the fields ID_V4L_CAPABILITIES to "video4linux", ENV{ID_SERIAL} to ID_SERIAL, ENV{ID_USB_INTERFACE_NUM} to ID_USB_INTERFACE_NUM, ENV{ID_V4L_CAPABILITIES} to ID_V4L_CAPABILITIES, ATTR{index} to output index from `cat /sys/class/video4linux/video4/index`, and SYMLINK to the name you would like it to be saved at in /dev/:
```
# Top RealSense - Depth (interface 00, capture only, index 2)
SUBSYSTEM=="video4linux", ENV{ID_SERIAL}=="Intel_R__RealSense_TM__Depth_Camera_435_Intel_R__RealSense_TM__Depth_Camera_435_804113020213", ENV{ID_USB_INTERFACE_NUM}=="00", ENV{ID_V4L_CAPABILITIES}==":capture:", ATTR{index}=="2", SYMLINK+="top_realsense_depth"

# Top RealSense - Color (interface 03, capture only)
SUBSYSTEM=="video4linux", ENV{ID_SERIAL}=="Intel_R__RealSense_TM__Depth_Camera_435_Intel_R__RealSense_TM__Depth_Camera_435_804113020213", ENV{ID_USB_INTERFACE_NUM}=="03", ENV{ID_V4L_CAPABILITIES}==":capture:", SYMLINK+="top_realsense_color"

# Top Webcam (UGREEN)
SUBSYSTEM=="video4linux", ENV{ID_SERIAL}=="UGREEN_Camera_UGREEN_Camera_SN0001", ENV{ID_V4L_CAPABILITIES}==":capture:", SYMLINK+="top_webcam"

# Overhead RealSense - Color (interface 03, capture only)
SUBSYSTEM=="video4linux", ENV{ID_SERIAL}=="Intel_R__RealSense_TM__Depth_Camera_435_Intel_R__RealSense_TM__Depth_Camera_435_823313020883", ENV{ID_USB_INTERFACE_NUM}=="03", ENV{ID_V4L_CAPABILITIES}==":capture:", SYMLINK+="overhead_realsense"
```

5. After exiting and saving the file (`Ctrl+x`, then `y`), run the following:

```
sudo udevadm control --reload-rules
sudo udevadm trigger
```

6. Then, run `ls /dev/` to see if your new symlink appears. Remove the USB device and run the command again to ensure the device disappears. Plug in the USB device and run the command again to ensure the device reappears. 

7. Add your device to agent-kibub/kibub_operator/DEVICES.py 

-------------------- **You are now finished the Client Software Setup** --------------------

## Teleop, recording datasets, rollout trained policies:

***CLIENT*** is needed for **teleoperating** the follower arms with the leader arms, and for **recording** datasets via teleop and cameras. The Sevrer is not needed for these operations. Scripts and instructions are found within the repository kibub_operator; use kibub_operator/so101_dual_arms/teleop_dual.py for teleoperating kibub_operator/so101_dual_arms/record_dual_with_cameras.py for recording.

***CLIENT*** and ***SERVER*** are both needed for **inferencing** trained policies. Scripts and instructions are found within the repository kibub_operator. You will need to start up the policy server on the Server, and the robot client on the Client. 

Reference agent-kibub/kibub_operator/README.md for scripts and instructions on the aforementioned operations!!

NOTE that training occurs on the SERVER or CLUSTER only. 

NOTE that any cameras should be specified in agent-kibub/kibub_operator/DEVICES.py and if you choose to add a camera, you must also update the udev rules on the client and the DEVICES.py file.

## Training policies:

***SERVER*** and ***CLUSTER*** are both capable of training policies. For training on the Server, use the training script described in agent-kibub/kibub_operator/README.md. For training on the Cluster, follow the instructions in agent-kibub/cluster/README.md.

## Openclaw agent:

***SERVER*** is needed for running the OpenClaw agent in isolation, where it will attempt to execute skills that require the Client to connect. So, if you intend to simply debug the Openclaw agent alone, you only need Server. To actually run actions on the robot and interface with cameras, sensors, and motors, proceed with the following steps: 

1. Power on the ***CLIENT*** computer (by pressing on the Intel NUC power button until the LED lights up blue)

2. (This step should have been completed in the Client setup, but is written here again for clarity) Paste the Client's IP address in the document agent-kibub/openclaw-embodied/KIBUB_IP. To find the Client IP address, SSH into Kibub and run `ip a`. Then, find the address under `wlp46s0`. See the example below, where the fourth entry `wlp46s0` indicates that Kibub' IP address is `10.145.8.176`. *(Note that the IP address likely only needs to be set up once but can change)*:

    ```
    (base) kibub@kibub:~$ ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host noprefixroute 
        valid_lft forever preferred_lft forever
    2: enp45s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
        link/ether a8:a1:59:d1:3f:26 brd ff:ff:ff:ff:ff:ff
    3: enp47s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
        link/ether a8:a1:59:d1:3f:27 brd ff:ff:ff:ff:ff:ff
    4: wlp46s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether bc:09:1b:f3:00:f7 brd ff:ff:ff:ff:ff:ff
        inet ***10.145.8.176***/24 brd 10.145.8.255 scope global dynamic noprefixroute wlp46s0
        valid_lft 84732sec preferred_lft 84732sec
        inet6 fe80::468d:503b:8449:53aa/64 scope link noprefixroute 
        valid_lft forever preferred_lft forever
    5: tailscale0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq_codel state UNKNOWN group default qlen 500
        link/none 
        inet 100.100.215.15/32 scope global tailscale0
        valid_lft forever preferred_lft forever
        inet6 fd7a:115c:a1e0::fd38:d70f/128 scope global 
        valid_lft forever preferred_lft forever
        inet6 fe80::85b0:94ee:21f:30c2/64 scope link stable-privacy 
        valid_lft forever preferred_lft forever
    6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
        link/ether b2:52:14:89:a1:15 brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
        valid_lft forever preferred_lft forever
    ```
3. On the Server, run `openclaw` in the terminal. 
4. When the OpenClaw terminal opens, run `talk to agent`. To set up and modify the OpenClaw agent, read the OpenClaw documentation https://docs.openclaw.ai/ and reference agent-kibub/openclaw-embodied/OPERATOR_README.md for more operator details. Note that the Openclaw agent's workspace should be set to openclaw-embodied, and that you can try different Openrouter models: https://openrouter.ai/models. 

## Agent Kibub 

Suppose you have your VLA models, you've set up the OpenClaw agent workspace, and you are ready to demo/evaluate the closed loop system (aka use the OpenClaw agent to reason about Kibub's environment and deploy both Gr00t skills and camera/motor skills on Kibub).

The following steps should be all you need to run the agent if the Client and Server have been configured. For more details, read agent-kibub/openclaw-embodied/OPERATOR_README.md.

1. Turn on both the Client and Server computer..
2. on the Server: `openclaw` then `talk to agent`.

## Troubleshooting

### Multiple cameras fighting over one port / despite multiple cameras connected, intermittent failure to capture at same time
- Change mode from JPEG to MJPG
- Use symlinks to avoid enumeration issues

### Training or recording fails midway
- Clean up the cache of old recordings and datasets

### Flash-attn not installing
- Install all packages first and flash-attn last (flash-attn needs to install against pre-existing packages)


--- END OF README.md ---