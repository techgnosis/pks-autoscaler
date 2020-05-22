# PKS Autoscaler

This project implements a workflow, within the OpsManager enviornment, to autoscale K8s clusters that have been deployed using PKS. The workflow relies on the BOSH's ability to capture compute level statistics of the VMs that constitue the worker nodes for the K8s clusters. 

## Features

* Runs within the OpsManager enviornment, leveraging the ability to consume BOSH and PKS APIs seamlessly. 
* Ability to run interactively or as a scheduled job. 
* Can resize clusters based on both CPU and memory parameters. 
* No external stats (e.g. Prometheus) required to achive auto-scaling.
* Ability to control high watermarks for memory and CPU on the fly. 
* Shrinks down unused compute based on low CPU usage watermark.

## Requirements

* SSH Access to Opsmanager VM.
* `om` CLI
* `pks` CLI
* `jq`, `bc`
* Configuration file `pks-autoscaler.config`. Sample provided. Modify as per your requirements.
 
 ## Setup

* Clone this repo.
* Modify the `pks-autoscaler.config` file.
* Make sure `pks` CLI is installed on Ops Manager VM in `/usr/local/bin/`
* Run the `pks-autoscaler-setup.sh` script to install `jq`, `om`, and `bc`
* Schedule `pks-autoscaler.sh` to run at whatever interval you need
