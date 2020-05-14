#! /usr/bin/env bash
set -euo pipefail

while true
do
    ./pks-autoscaler.sh
    echo "Waiting 60 seconds until next autoscale check"
    sleep 60
done