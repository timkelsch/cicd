#!/bin/bash

set -euxo pipefail

docker exec -u root jenkins bash -c "chgrp docker /var/run/docker.sock"
docker exec -u root jenkins bash -c "chmod 770 /var/run/docker.sock"
docker exec -u root jenkins bash -c "ls -l /var/run/docker.sock"

docker exec -u root jenkins bash -c 'echo '''alias ll="ls -al"''' >> ~/.bashrc'