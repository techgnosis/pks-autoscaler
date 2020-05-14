#! /usr/bin/env bash
set -euo pipefail

while true
do
    ./pks-autoscaler.sh
    sleep 60
done