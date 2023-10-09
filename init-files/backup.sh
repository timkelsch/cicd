#!/bin/bash

set -euxo pipefail

TIMESTAMP=$(date "+%Y%m%d-%H%M%S")
MOUNT_DIR='/var/lib/docker/volumes/jenkins-data'
TARBALL='jenkins_home.tgz'
BACKUP_BUCKET='my-jenkins-backup'
ENVIRONMENT='prod'

# Stop Container
docker container stop jenkins

# Create tarball backup
cd "$MOUNT_DIR"
tar --exclude="_data/workspace" --exclude "_data/jobs/mfl-scoring/builds" -zcvf "$TARBALL" _data

# Start Container
docker container start jenkins

# Backup tarball to S3
aws s3 cp "$TARBALL" "s3://$BACKUP_BUCKET/$ENVIRONMENT-backups/jenkins_home.$TIMESTAMP.tgz"

# Delete tarball
rm -rf "$MOUNT_DIR/$TARBALL"