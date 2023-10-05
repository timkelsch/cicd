#!/bin/bash

set -euxo pipefail

BJ='jenkins'

DOCKER_BUILDKIT=1 docker build -t $BJ .
#docker run --name $BJ --restart=on-failure --detach --publish 8080:8080 --publish 50000:50000 -volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro $BJ
docker run --name $BJ --restart=on-failure --detach --publish 8080:8080 --publish 50000:50000 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro --volume /var/run/docker.sock:/var/run/docker.sock $BJ