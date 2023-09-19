#!/bin/bash

set -euxo pipefail

URL=$(grep -oh 'http.*8080/' jenkins.model.JenkinsLocationConfiguration.xml)
PW=$(cat /var/jenkins_home/secrets/initialAdminPassword)

while read -u 9 -r line
  do java -jar jenkins-cli.jar -s "$URL" -auth admin:"$PW" install-plugin "$line"
  echo "$?"
done 9< jenkins-plugins.txt