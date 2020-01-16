#!/usr/bin/env bash

set -xe

rm -rf ./bs1 && mkdir -p ./bs1
tar -czvf ./bs1/b1.tar.gz -C ./b1 .

rm -rf ./bs2 && mkdir -p ./bs2
tar -czvf ./bs2/b2.tar.gz -C ./b2 .

rm -rf ./dbs1 && mkdir -p ./dbs1/example
tar -czvf ./dbs1/example/discovery -C ./db1 .

cp ./bs1/b1.tar.gz ./dbs1/
cp ./bs2/b2.tar.gz ./dbs1/