#!/usr/bin/env bash

set -xe

screen -S opa -X quit || echo "no screen session?"

screen -AmdS opa
screen -S opa -X screen $(pwd)/start-bundle-server.sh 1
screen -S opa -X screen $(pwd)/start-bundle-server.sh 2
screen -S opa -X screen $(pwd)/postr-server.py --port 8883
screen -r opa
