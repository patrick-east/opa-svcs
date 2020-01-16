#!/usr/bin/env bash

set -ex

docker ps -a | grep bundle-server | awk '{print $1}' | xargs docker rm -f
docker rm -f discovery-server-1 || true
rm -rf ./tmp
