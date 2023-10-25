#!/bin/bash

set -euxo pipefail

TIMESTAMP=$(date "+%Y%m%d-%H%M%S")
MOUNT_DIR='/var/lib/docker/volumes/jenkins-data'
TARBALL='jenkins_home.tgz'
BACKUP_BUCKET='storage-cicdpipeline-116815dy3bgkm'
BACKUP_PREFIX='jenkins-backups'
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)

die() { status=$1; shift; echo "FATAL: $*"; exit $status; }
EC2_INSTANCE_ID="`curl http://169.254.169.254/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"

# Stop Container
docker container stop jenkins

# Create tarball backup
cd "${MOUNT_DIR}"
tar --exclude="_data/workspace" --exclude "_data/jobs/mfl-scoring/builds" -zcvf "${TARBALL}" _data
# TODO: Keep the latest build - hopefully avoiding the manual build before webhooks start working

# Start Container
docker container start jenkins

# Backup tarball to S3
aws s3 cp "${TARBALL}" "s3://${BACKUP_BUCKET}/${BACKUP_PREFIX}/jenkins.${TIMESTAMP}.${INSTANCE_ID}.tgz"

# Delete tarball
rm -rf "${MOUNT_DIR}/${TARBALL}"