#!/bin/bash

set -euxo pipefail

# stop container
# docker container stop jenkins

# modify config file
# sed -i -- 's/<excludeClientIPFromCrumb>false/<excludeClientIPFromCrumb>true/g' /var/jenkins_home/config.xml
docker exec -u root jenkins bash -c 'hostname'
docker exec -u root jenkins bash -c 'ls -l /var/jenkins_home/config.xml'
docker exec -u root jenkins bash -c 'sed -i -- '"'"'s/<excludeClientIPFromCrumb>false/<excludeClientIPFromCrumb>true/g'"'"' /var/jenkins_home/config.xml'

# start container
docker container restart jenkins