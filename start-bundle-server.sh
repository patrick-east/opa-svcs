#!/usr/bin/env bash

set -ex

num=$1

docker rm -f opa-bs${num} || true

echo "Starting nginx on port 888${num}"
docker run --rm --name opa-bs${num} -p 888${num}:80 -v $(pwd)/bs${num}/:/usr/share/nginx/html:ro nginx
