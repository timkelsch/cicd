#!/bin/bash

# stop container
docker container stop jenkins

# modify config file
sed -i -- 's/<excludeClientIPFromCrumb>false/<excludeClientIPFromCrumb>true/g' /var/jenkins_home/config.xml

# start container
docker container start jenkins