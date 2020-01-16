#!/usr/bin/env bash

set -ex

./unjuice.sh

# dumb work around for osx and it not sharing tmp directories with docker..
TMPDIR=./tmp/$(uuidgen)
mkdir -p ${TMPDIR}
TMPDIR=$(realpath ${TMPDIR})

DICOVERY_BUNDLE_DIR=${TMPDIR}/discovery
DISCOVERY_FILE=${DICOVERY_BUNDLE_DIR}/data.yaml

mkdir -p ${DICOVERY_BUNDLE_DIR}

cat <<EOF >> ${DISCOVERY_FILE}
juiced:
  discovery:
    decision_logs:
      console: false
    status:
      service: postr
EOF

cat <<EOF >> ${DISCOVERY_FILE}
    bundles:
EOF

for i in $(seq 2 $1); do
    bundle_dir=${TMPDIR}/${i}
    mkdir -p ${bundle_dir}
    mkdir ${bundle_dir}/${i}
    echo "{\"x\": $i}" > ${bundle_dir}/${i}/data.json
    echo "{\"revision\": \"abc${i}\", \"roots\": [\"${i}\"]}" > ${bundle_dir}/.manifest
    tar -czvf ${TMPDIR}/b${i}.tar.gz -C ${bundle_dir} .

    cat <<EOF >> ${DISCOVERY_FILE}
      bundle-${i}:
        service: "service-${i}"
        resource: "opa-bundles/b${i}.tar.gz"
EOF
done

tar -czvf ${TMPDIR}/discovery.tar.gz  -C ${DICOVERY_BUNDLE_DIR} .


docker run --rm -d --name discovery-server-1 -p 8891:80 -v ${TMPDIR}:/usr/share/nginx/html:ro nginx


CFG_FILE=${TMPDIR}/opa.yaml

cat <<EOF > ${CFG_FILE}
discovery:
  name: juiced/discovery
  resource: /discovery.tar.gz 
  service: dbs1
  polling:
    min_delay_seconds: 5
    max_delay_seconds: 5

services:
  dbs1:
    url: http://localhost:8891/
  postr:
    url: http://localhost:8881/
EOF

for i in $(seq 2 $1); do
    cat <<EOF >> ${CFG_FILE}
  service-${i}:
    url: "https://storage.googleapis.com/"
EOF
done

echo "now run.."
echo "./postr-server -p 8880"
echo "opa run -s -c ${CFG_FILE}"
