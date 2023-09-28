#!/bin/bash

set -euxo pipefail

#URL=$(grep -oh 'http.*8080/' jenkins.model.JenkinsLocationConfiguration.xml)
PUBLIC_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
URL="http://$PUBLIC_HOSTNAME:8080/"
PW=$(cat /var/jenkins_home/secrets/initialAdminPassword)
FILE='jenkins-plugins.txt'
JCLI='jenkins-cli.jar'

curl "http://$PUBLIC_HOSTNAME:8080/jnlpJars/$JCLI" -o "$JCLI"

while read -u 9 -r line
  do java -jar "$JCLI" -s "$URL" -auth admin:"$PW" install-plugin "$line"
  echo "$?"
done 9< "$FILE"

java -jar "$JCLI" -s "$URL" -auth admin:"$PW" restart