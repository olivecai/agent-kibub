#!/bin/bash
set -e # script will exit on any error

# Run this script on the Server, with current working directory as agent-kibub,
# to remotely set up the Kibub Client environment over SSH.
# PRECAUTION: requires passwordless SSH access to kibub@kibub (key-based auth),
# since the remote commands run non-interactively.

KIBUB_HOST="kibub@kibub"
KIBUB_HOME="/home/kibub"

echo "LOGGING: copying client_requirements.txt to the Kibub client:"
scp client_requirements.txt "${KIBUB_HOST}:${KIBUB_HOME}/client_requirements.txt"

echo "LOGGING: running remote environment setup on the Kibub client:"
ssh "${KIBUB_HOST}" bash -s <<'EOF'
set -e
source "$(conda info --base)/etc/profile.d/conda.sh"
cd /home/kibub

clone_or_pull() {
    repo_url=$1
    repo_name=$2
    if [ -d "$repo_name/.git" ]; then
        echo "LOGGING: $repo_name already cloned, running git pull origin main:"
        (cd "$repo_name" && git pull origin main)
    else
        echo "LOGGING: cloning $repo_name:"
        git clone "$repo_url" "$repo_name"
    fi
}

echo "LOGGING: git clone/pull kibub-neck-servos, kibub_diff_drive, kibub_operator:"
clone_or_pull https://github.com/olivecai/kibub-neck-servos kibub-neck-servos
clone_or_pull https://github.com/olivecai/kibub_diff_drive kibub_diff_drive
clone_or_pull https://github.com/olivecai/kibub_operator kibub_operator

echo "LOGGING: creating conda env:"
conda deactivate 2>/dev/null || true
conda create -n lerobot -y
conda activate lerobot

echo "LOGGING: populate the venv:"
cd kibub_operator
pip install -r /home/kibub/client_requirements.txt
EOF

echo "LOGGING: Kibub client environment setup complete."
