#!/bin/bash

set -euxo pipefail

CONFIG_BUCKET='storage-cicdpipeline-116815dy3bgkm'
CONFIG_BUCKET_PREFIX='init-files'

if [[ "$OSTYPE" == "darwin"* ]]; then 
  TAR='gtar'
else
  TAR='tar'
fi

cd ..
${TAR} zcvf init.tgz init-files
aws s3 cp init.tgz s3://${CONFIG_BUCKET}/${CONFIG_BUCKET_PREFIX}/
rm -f init.tgz