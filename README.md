# PKS Autoscaler

**NOT FOR PRODUCTION USE**

This project implements a workflow, within the OpsManager enviornment, to autoscale K8s clusters that have been deployed using PKS. The workflow relies on the BOSH's ability to capture compute level statistics of the VMs that constitue the worker nodes for the K8s clusters. 

## Features

* Runs within the OpsManager enviornment, leveraging the ability to consume BOSH and PKS APIs seamlessly. 
* Ability to run interactively or as a scheduled job. 
* Can resize clusters based on both CPU and memory parameters. 
* Ability to exclude clusters from auto-scaling
* Ability to exclude memory stats during auto-scaling
* Ability to stop entire script execution on the fly to honor environment maintainance.
* Honors the PKS plan's min and max node sizing and operates within those boundaries. 
* No external stats (e.g. Prometheus) required to achive auto-scaling.
* No requirements to store/expose enviornment credentials. All credentials are requested and consumed using those stored in CredHub. 
* Ability to control high watermarks for memory and CPU on the fly. 
* Shrinks down unused compute based on low CPU usage watermark.

## Requirements

* SSH Access to Opsmanager VM.
* OM CLI
* PKS CLI
* JQ, Python YQ package, BC
* Configuration file `pks-autoscaler.config`. Sample provided. Modify as per your requirements.
 
 ## Setup

* Clone this repo.
* Modify the `pks-autoscaler.config` file.
* Make sure `pks` CLI is installed on Ops Manager VM in `/usr/local/bin/`
* Make sure `om` CLI is installed on Ops Manager VM in `/usr/local/bin/`
* Run the `pks-autoscaler-setup.sh` script to install `jq`, `yq`, and `bc` and add credentials to scripts
* Schedule the `pks-autoscaler-schduler.sh` or execute the `pks-autoscaler.sh`
    * `pks-autoscaler-scheduler.sh` runs one time
    * `pks-autoscaler.sh` runs in a while-loop