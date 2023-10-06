#!/bin/bash

set -euxo pipefail

docker exec -u root jenkins bash -c "chgrp docker /var/run/docker.sock"
docker exec -u root jenkins bash -c "chmod 770 /var/run/docker.sock"
docker exec -u root jenkins bash -c "ls -l /var/run/docker.sock"

docker exec -u root jenkins bash -c 'echo '''alias ll="ls -al"''' >> ~/.bashrc'
docker exec -u root jenkins bash -c 'echo '''alias si="/opt/aws/bin/cfn-init \
  -v --stack jenkins-cheap --resource EC2Instance1 --configsets jenkins_install --region us-east-1"''' >> ~/.bashrc'