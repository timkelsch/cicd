#!/bin/bash

set -euxo pipefail

#install aws-cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

#install aws-sam-cli
mkdir -p ~/sam
cd ~/sam
python3 -m venv venv
. venv/bin/activate
pip install --upgrade aws-sam-cli
echo 'alias sam=/var/jenkins_home/sam/venv/bin/sam' >> ~/.bashrc

echo 'alias ll="ls -al"' >> ~/.bashrc