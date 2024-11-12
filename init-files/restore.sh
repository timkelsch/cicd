#!/bin/bash

set -euxo pipefail

BACKUP_FILE=$1
BACKUP_BUCKET='storage-cicdpipeline-116815dy3bgkm'
BACKUP_PREFIX='jenkins-backups'
MOUNT_DIR='/var/lib/docker/volumes/jenkins-data'
ENVIRONMENT='prod'

# Stop Container
if docker container ls --format table | grep 'jenkins/jenkins'; then
  docker container stop $(docker container ls --filter ancestor=jenkins/jenkins --format json | jq -r '.Names')
fi

# Pull backup from S3
cd "${MOUNT_DIR}"
aws s3 cp "s3://${BACKUP_BUCKET}/${BACKUP_PREFIX}/${BACKUP_FILE}" .

# Unpack tarball
tar --overwrite -zxvpf "${BACKUP_FILE}"

# Start Container
docker container start jenkins/jenkins

# Delete tarball
rm -rf "${MOUNT_DIR}/${BACKUP_FILE}"
