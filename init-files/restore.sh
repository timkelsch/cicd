#!/bin/bash

set -euxo pipefail

BACKUP_FILE=$1
BACKUP_BUCKET='my-jenkins-backup'
MOUNT_DIR='/var/lib/docker/volumes/jenkins-data'
ENVIRONMENT='prod'

# Stop Container
docker container stop jenkins

# Pull backup from S3
cd "$MOUNT_DIR"
aws s3 cp "s3://$BACKUP_BUCKET/$ENVIRONMENT-backups/$BACKUP_FILE" .

# Unpack tarball
tar --overwrite -zxvpf "$BACKUP_FILE"

# Start Container
docker container start jenkins

# Delete tarball
rm -rf "$MOUNT_DIR/$BACKUP_FILE"