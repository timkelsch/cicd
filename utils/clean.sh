#!/bin/bash

JB='jenkins'

docker stop $JB
docker rm $JB
docker container prune -f
docker image prune -f
docker volume prune -f