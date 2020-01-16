#!/usr/bin/env bash

set -ex

num=$1

docker rm -f opa-dbs${num} || true

echo "Starting nginx on port 889${num}"
docker run --rm --name opa-dbs${num} -p 889${num}:80 -v $(pwd)/dbs${num}/:/usr/share/nginx/html:ro nginx
