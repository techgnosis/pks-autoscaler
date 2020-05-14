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
* JQ, Python YQ package, BC 
* PKS CLI (may need to be setup **manually** on the Opsmanager server at the following location `/usr/local/bin/pks`)
* Configuration file `pks-autoscaler.config`. Sample provided. Modify as per your requirements.
 
 ## Setup

* Clone this repo.
* Modify the `pks-autoscaler.config` file.
* Modify the values of following entries in `pks-autoscaler.sh` and `pks-autoscaler-scheduler.sh` 
    * `OM_USERNAME="om_user"`
    * `OM_PASSWORD="om_password"`
* Run the `pks-autoscaler-setup.sh` script to setup required binaries. 
* Make sure `pks` CLI is installed.
* Schedule the `pks-autoscaler-schduler.sh` or execute the `pks-autoscaler.sh`