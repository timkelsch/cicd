#!/bin/bash

set -euxo pipefail

BACKUP_FILE=$1
BACKUP_BUCKET='storage-cicdpipeline-116815dy3bgkm'
BACKUP_PREFIX='jenkins-backups'
MOUNT_DIR='/var/lib/docker/volumes/jenkins-data'
IMAGE_NAME='jenkins-mfl'

# Stop Container
if docker container ls --format table | grep "${IMAGE_NAME}"; then
  docker container stop "${IMAGE_NAME}"
fi

# Pull backup from S3
cd "${MOUNT_DIR}"
aws s3 cp "s3://${BACKUP_BUCKET}/${BACKUP_PREFIX}/${BACKUP_FILE}" .

# Unpack tarball
tar --overwrite -zxvpf "${BACKUP_FILE}"

# Start Container
docker container start "${IMAGE_NAME}"

# Delete tarball
rm -rf "${MOUNT_DIR}/${BACKUP_FILE}"
