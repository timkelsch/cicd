#!/bin/bash

set -euxo pipefail

# wait for jenkins install to complete to be sure config.xml file exists
date
docker exec -u root jenkins bash -c \
  'C=0; while [[ ! -f /Users/tkelsch/tmp/docker/config.xml ]] && [[ $C -lt 60 ]]; do sleep 2; ((C++)); echo $C; done'
date 

# modify config file
docker exec -u root jenkins bash -c 'ls -l /var/jenkins_home'
docker exec -u root jenkins bash -c 'ls -l /var/jenkins_home/config.xml'
docker exec -u root jenkins bash -c \
  'sed -i -- '"'"'s/<excludeClientIPFromCrumb>false/<excludeClientIPFromCrumb>true/g'"'"' /var/jenkins_home/config.xml'

# restart container
docker container restart jenkins