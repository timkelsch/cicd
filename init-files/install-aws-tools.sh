#!/bin/bash

set -euxo pipefail

# this needs to be installed as jenkins user
# install aws-sam-cli
mkdir -p ~/sam
cd ~/sam
python3 -m venv venv
. venv/bin/activate
pip install --upgrade aws-sam-cli
echo 'alias sam=/var/jenkins_home/sam/venv/bin/sam' >> ~/.bashrc

echo 'alias ll="ls -al"' >> ~/.bashrc
# sudo /opt/aws/bin/cfn-init -v --stack jenkins-cheap --resource EC2Instance1 --configsets jenkins_install --region us-east-1 &