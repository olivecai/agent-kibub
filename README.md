# agent-kibub
'Agent Kibub' refers to the OpenClaw agentic system embodied on a dual arm, differential drive mobile robot system 'Kibub'.  This master repository contains the submodules needed to teleop, train, inference on Kibub, and the agent setup for OpenClaw.

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
2. Initialize and update the submodule repositories by running `cd agent-kibub; git submodule init; git submodule update`
3. Install miniconda so that you can use virtual environments to manage packages: https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install (`curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh` and after it has installed, `source ~/.bashrc`)
4. Run the cmd to setup the server environment: `./CreateVenv-SERVER.sh`

#### OpenClaw Agent

5. Set up the OpenClaw agent:


### Client Software Setup:

*Presumably Kibub has already been set up but these steps will be documented for redundancy*

1. Launch a Kibub SSH session: `ssh kibub@kibub`. 
2. Clone the following three repositories in /home/kibub/: kibub-neck-servos (https://github.com/olivecai/kibub-neck-servos), kibub_diff_drive (https://github.com/olivecai/kibub_diff_drive), and kibub_operator (https://github.com/olivecai/kibub_operator). If they are already cloned, cd into each of them and `git pull origin main`
3. Run `conda create env -n lerobot -y; conda activate lerobot`
4. Run `cd kibub_operator; pip install -r client-requirements.txt`

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


If you are missing a symlnik, add it using udev rules:

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


## Teleop, recording datasets, rollout trained policies:

***CLIENT*** is needed for **teleoperating** the follower arms with the leader arms, and for **recording** datasets via teleop and cameras. The Sevrer is not needed for these operations. Scripts and instructions are found within the repository kibub_operator; use kibub_operator/so101_dual_arms/teleop_dual.py for teleoperating kibub_operator/so101_dual_arms/record_dual_with_cameras.py for recording.

***CLIENT*** and ***SERVER*** are both needed for **inferencing** trained policies. Scripts and instructions are found within the repository kibub_operator. You will need to start up the policy server on the Server, and the robot client on the Client. 

Reference agent-kibub/kibub_operator/README.md for scripts and instructions on the aforementioned operations!!

NOTE that training occurs on the SERVER or CLUSTER only.

## Training policies:

***SERVER*** and ***CLUSTER*** are both capable of training policies. For training on the Server, use the training script described in agent-kibub/kibub_operator/README.md. For training on the Cluster, follow the instructions in agent-kibub/cluster/README.md.

## Openclaw agent:

***SERVER*** is needed for running the OpenClaw agent in isolation, where it will attempt to execute skills that require the Client to connect. So, if you intend to simply debug the Openclaw agent alone, you only need Server, but to actually run actions on the robot and interface with cameras/sensors/motors, you must also turn on the ***CLIENT***. On the server, run `openclaw`. When the terminal opens, run `talk to agent` and choose your Kibub agent. To set up and modify the OpenClaw agent, read the OpenClaw documentation https://docs.openclaw.ai/ and reference agent-kibub/openclaw-embodied/OPERATOR_README.md for more operator details. Note that the Openclaw agent's workspace should be set to openclaw-embodied, and that you can try different Openrouter models: https://openrouter.ai/models

# Agent Kibub 

Suppose you have your VLA models, you've set up the OpenClaw agent workspace, and you are ready to demo/evaluate the closed loop system (aka use the OpenClaw agent to reason about Kibub's environment and deploy both Gr00t skills and camera/motor skills on Kibub).

Below is your cheatsheet. For more details, read agent-kibub/openclaw-embodied/OPERATOR_README.md.
